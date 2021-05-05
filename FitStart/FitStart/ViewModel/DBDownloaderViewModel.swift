//
//  UserViewModel.swift
//  FitStart
//
//  Created by Memphis Meng on 4/23/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class DBDownloaderViewModel: ObservableObject {
    @Published var currentXP: Int?
    @Published var currentLevel: Int?
    @Published var topFiveUsers = [DBUploaderViewModel]()
    private var db = Firestore.firestore().collection("Users")
        
    public init() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // catch the information of the current user
        let docRef = db.document(uid)
        docRef.getDocument { (snapshot, error) in
            if let doc = snapshot,
               let xp = doc.get("xp") as? Int,
               let level = doc.get("level") as? Int {
                self.currentXP = xp
                self.currentLevel = level
            } else if let error = error {
                print(error)
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
