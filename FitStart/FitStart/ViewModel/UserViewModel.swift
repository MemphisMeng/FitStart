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
    // TODO
    let current_user_id = Auth.auth().currentUser!.uid
    private var db = Firestore.firestore()
    @Published var xp:Int?
    
    func fetchData(completion: @escaping () -> Void) {
        let docRef = db.collection("users").document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let xp = document.data()!["xp"] as! Int
//                // fetch the experience score
//                completion()
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        docRef.getDocument { snapshot, error in
              print(error ?? "No error.")
              self.xp = 0
              guard let snapshot = snapshot else {
                  completion()
                  return
              }
            self.xp = (snapshot.data()!["xp"] as! Int)
            completion()
        }
    }
}
