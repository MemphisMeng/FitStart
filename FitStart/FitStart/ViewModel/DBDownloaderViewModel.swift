//
//  UserViewModel.swift
//  FitStart
//
//  Created by Memphis Meng on 4/23/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class DBDownloaderViewModel: ObservableObject {
    @Published var currentXP: Int?
    @Published var currentLevel: Int?
    @Published var currentName: String?
    @Published var currentBio: String?
    @Published var currentInterest: String?
    @Published var currentPhoto: Image?
    @Published var topFiveUsers = [DBUploaderViewModel]()
    private var ref = Firestore.firestore()
        
    public init() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // catch the information of the current user
        let db = ref.collection("Users")
        db.addSnapshotListener { [self] (querySnapshot, error) in
            guard (querySnapshot?.documents) != nil else {
                print("Document is empty")
                return
            }
            let docRef = db.document(uid)
            
            docRef.getDocument { (snapshot, error) in
                if let doc = snapshot,
                   let xp = doc.get("xp") as? Int,
                   let level = doc.get("level") as? Int,
                   let name = doc.get("username") as? String,
                   let interest = doc.get("interest") as? String,
                   let bio = doc.get("bio") as? String {
                    self.currentXP = xp
                    self.currentLevel = level
                    self.currentBio = bio
                    self.currentName = name
                    self.currentInterest = interest
                    let store = Storage.storage().reference()
                    let imageRef = store.child("profile_Photos").child(uid)
                    imageRef.getData(maxSize: 1000 * 64 * 64, completion: { (data, error) in
                        if let error = error {
                            print("Encountered error: \(error) when getting image")
                            self.currentPhoto = Image(systemName: "person").resizable()
                        } else {
                            self.currentPhoto = Image(uiImage: UIImage(data: data!)!).resizable()
                        }
                      })
                } else if let error = error {
                    print(error)
                }
            }
        }
        
        let top5 = db.order(by: "xp", descending: true).limit(to: 5)
        top5.addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("Document is empty")
                return
            }
            self.topFiveUsers = documents.map {
                (QueryDocumentSnapshot) -> DBUploaderViewModel in
                let data = QueryDocumentSnapshot.data()
                let xp = data["xp"]
                let name = data["username"]
                return DBUploaderViewModel(name:name as? String ?? "", xp:xp as? Int ?? 0)
            }
        }
    }
}
