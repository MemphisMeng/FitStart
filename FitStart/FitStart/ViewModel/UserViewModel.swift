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
    @Published var xp: Int?
    @Published var users = []
    private var db = Firestore.firestore().collection("users")
        
    init() {
        // TODO
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")

        docRef.getDocument { (snapshot, error) in
            if let doc = snapshot,
               let xp = doc.get("xp") as? Int {
                self.xp = xp
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func fetchTopFive() {
        // top five users who got the highest xp scores
        let docRef = db.order(by: "xp", descending: true).limit(to: 5)
        docRef.addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("Document is empty")
                return
            }
            self.users.append(
                documents.map { (QueryDocumentSnapshot) -> Array<Any> in
                let data = QueryDocumentSnapshot.data()
                
                let xp = data["xp"]
                let name = data["name"]
                
                    return [xp ?? 0, name ?? ""]
                }
            )
            print(self.users)
        }
    }
}
