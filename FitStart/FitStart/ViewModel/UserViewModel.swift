//
//  UserViewModel.swift
//  FitStart
//
//  Created by Memphis Meng on 4/23/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var currentUser = RegisterViewModel()
    @Published var topFiveUsers = [RegisterViewModel]()
    private var db = Firestore.firestore().collection("users")
        
    init() {
        // TODO
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // catch the information of the current user
        let docRef = db.document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")
        docRef.getDocument { (snapshot, error) in
            if let doc = snapshot,
               let xp = doc.get("xp") as? Int,
               let name = doc.get("name") as? String {
                self.currentUser.name = name
                self.currentUser.xp = xp
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
                (QueryDocumentSnapshot) -> RegisterViewModel in
                let data = QueryDocumentSnapshot.data()
                let xp = data["xp"]
                let name = data["name"]
                print(RegisterViewModel(name:name as? String ?? "", xp:xp as? Int ?? 0))
                return RegisterViewModel(name:name as? String ?? "", xp:xp as? Int ?? 0)
            }
        }
    }
    
    // catch the information of the top 5 users with most credits
    func fetchData() {
        let top5 = db.order(by: "xp", descending: true).limit(to: 5)
        top5.addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("Document is empty")
                return
            }
        self.topFiveUsers = documents.map { (QueryDocumentSnapshot) -> RegisterViewModel in
                                let data = QueryDocumentSnapshot.data()
                                let xp = data["xp"]
                                let name = data["name"]
                                return RegisterViewModel(name:name as? String ?? "", xp:xp as? Int ?? 0)
                            }
        }
    }
}
