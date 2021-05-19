//
//  topUsersViewModel.swift
//  FitStart
//
//  Created by Memphis Meng on 5/7/21.
//

import Foundation
import Firebase

class topUsersViewModel: ObservableObject {
    @Published var users = [userModel]()
    private var ref = Firestore.firestore()
    private let store = Storage.storage().reference()
    
    func updateTopUsers(completion: @escaping () -> [userModel]) -> [userModel]{
        let db = ref.collection("Users")
        let top5 = db.order(by: "xp", descending: true).limit(to: 5)
        
        top5.addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("Document is empty")
                return
            }
            self.users = documents.map {
                (QueryDocumentSnapshot) -> userModel in
                let data = QueryDocumentSnapshot.data()
                let xp = data["xp"]
                let name = data["username"]
                return userModel(name as? String ?? "", xp as? Int ?? 0)
            }
        }
        return completion()
    }
    
    public func getTopUsers() -> [userModel] {
        updateTopUsers(completion: {
            return (self.users) as [userModel]
        })
    }
}
