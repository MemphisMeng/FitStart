//
//  RegisterViewModel.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject {
//    struct FBUser: Identifiable {
//        let id = UUID()
//        let uid: String
//        let name: String
//        let email: String
//        let bio: String
//        let interest: String
//        let level: Int
//        let xp: Int
//    }
    
    @Published var name = ""
    @Published var bio = ""
    @Published var interest = ""
    @Published var level = 0
    @Published var xp = 0
    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    
    let ref = Firestore.firestore()
    
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    func register() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser!.uid
        
        isLoading = true
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            self.ref.collection("Users").document(uid).setData([
                            "uid": uid,
                            "imageurl": url,
                            "username": self.name,
                            "bio": self.bio,
                            "interest" : self.interest,
                            "level" : self.level,
                            "xp" : self.xp,
                            "dateCreated": Date()
                            
                        ]) { (err) in
                         
                            if err != nil{
                                self.isLoading = false
                                return
                            }
                            self.isLoading = false
                            // success means settings status as true...
                            self.status = true
                        }
            
        }
    }
}
