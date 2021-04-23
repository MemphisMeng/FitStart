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
        
    init() {
        // TODO
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = Firestore.firestore().collection("users").document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")

        docRef.getDocument { (snapshot, error) in
            if let doc = snapshot,
               let xp = doc.get("xp") as? Int {
                self.xp = xp
            } else if let error = error {
                print(error)
            }
        }
    }
}
