//
//  RegisterViewModel.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase

class User : ObservableObject, Identifiable {
    @Published var name = ""
    @Published var bio = ""
    @Published var interest = ""
    @Published var level = 1
    @Published var xp = 0
    @Published var email = ""
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    
    let ref = Firestore.firestore()
    
    @Published var isLoading = false
    @AppStorage("status") var status = false
    
    // common init
    init() {
        
    }
    
    //initializer for leaderboard collection
    init(name: String, xp: Int) {
        self.name = name
        self.xp = xp
        self.level = User.xp2Level(xp: xp)
    }
    
    func update() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser!.uid
        
        isLoading = true
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            self.ref.collection("Users").document(uid).setData([
                            "uid": uid,
                            "imageurl": url,
                            "username": self.name,
                            "bio": self.bio,
                            "interest" : self.interest
                        ], merge: true) { (err) in
                         
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
    
    static func xp2Level(xp:Int) -> Int {
        if xp < 9500 {
            return xp / 500 + 1
        }
        else if xp < 29500 {
            return (xp - 9500) / 1000 + 1
        }
        else {
            return (xp - 29500) / 2000 + 1
        }
    }
}
