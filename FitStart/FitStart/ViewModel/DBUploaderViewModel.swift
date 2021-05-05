//
//  RegisterViewModel.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase
import FirebaseStorage

class DBUploaderViewModel : ObservableObject, Identifiable {
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
        self.level = self.xp2Level(xp: xp)
    }
    
    func updatePersonalInfo() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser?.uid
        
        isLoading = true
        self.UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            self.ref.collection("Users").document(uid ?? "").setData([
                            "uid": uid ?? "",
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
    
    func updateXPnLV() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser!.uid
        let docRef = ref.collection("Users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let xp = document.data()!["xp"] as! Int + 50
                docRef.updateData(["xp": xp])
                // update level
                docRef.updateData(["level": self.xp2Level(xp: xp)])
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func xp2Level(xp:Int) -> Int {
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
    
    func UploadImage(imageData: Data, path: String, completion: @escaping (String) -> ()){
        
        let storage = Storage.storage().reference()
        let uid = Auth.auth().currentUser?.uid
        
        storage.child(path).child(uid ?? "").putData(imageData, metadata: nil) { (_, err) in
            
            if err != nil{
                completion("")
                return
                
            }
            // Downloading Url And Sending Back...
            storage.child(path).child(uid ?? "").downloadURL { (url, err) in
                if err != nil{
                    completion("")
                    return
                    
                }
                completion("\(url!)")
            }
        }
    }
}
