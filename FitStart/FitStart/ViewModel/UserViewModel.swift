//
//  UserViewModel.swift
//  FitStart
//
//  Created by Memphis Meng on 5/17/21.
//

import Foundation
import SwiftUI
import Firebase

class userViewModel: ObservableObject {
    @Published var user: userModel = userModel()
    
    @Published var isLoading = false
    @AppStorage("status") var status = false
    private var ref = Firestore.firestore()
    private let store = Storage.storage().reference()
    var picker = false
    
    func updateXP(completion: @escaping () -> Int) -> Int {
        guard let uid = Auth.auth().currentUser?.uid else {
            return 0
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
                   let xp = doc.get("xp") as? Int {
                    self.user.xp = xp
                }
            }
        }
        return completion()
    }
    
    func updateLevel(completion: @escaping () -> Int) -> Int {
        guard let uid = Auth.auth().currentUser?.uid else {
            return 1
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
                   let level = doc.get("level") as? Int {
                    self.user.level = level
                }
            }
        }
        return completion()
    }
    
    func updateName (completion: @escaping () -> String) -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            return ""
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
                   let name = doc.get("username") as? String {
                    self.user.name = name
                }
            }
        }
        return completion()
    }
    
    func updateBio (completion: @escaping () -> String) -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            return ""
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
                   let bio = doc.get("bio") as? String {
                    self.user.bio = bio
                }
            }
        }
        return completion()
    }
    
    func updateInterest (completion: @escaping () -> String) -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            return ""
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
                   let interest = doc.get("interest") as? String {
                    self.user.interest = interest
                }
            }
        }
        return completion()
    }
    
    func updatePhoto (completion: @escaping () -> Data) -> Data {
        guard let uid = Auth.auth().currentUser?.uid else {
            return Data(count: 0)
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
                if snapshot != nil {
                    let imageRef = store.child("profile_Photos").child(uid)
                    imageRef.getData(maxSize: 1000 * 64 * 64, completion: { (data, error) in
                        if let error = error {
                            print("Encountered error: \(error) when getting image")
                            self.user.image = Data(count: 0)
                        } else if let data = data,
                                  !data.isEmpty{
//                            self.currentUser.image = Image(uiImage: UIImage(data: data)!).resizable()
                            self.user.image = data
                        } else {
//                            self.currentUser.image = Image(systemName: "person").resizable()
                            self.user.image = Data(count: 0)
                        }
                      })
                } else if let error = error {
                    print(error)
                }
            }
        }
        return completion()
    }
    
    public func getXP() -> Int{
        updateXP {
            return (self.user.xp) as Int
        }
    }
    
    public func getLevel() -> Int {
        updateLevel(completion: {
            return (self.user.level) as Int
        })
    }
    
    public func getName() -> String {
        updateName(completion: {
            return (self.user.name) as String
        })
    }
    
    public func getBio() -> String {
        updateBio(completion: {
            return (self.user.bio) as String
        })
    }
    
    public func getInterest() -> String {
        updateInterest(completion: {
            return (self.user.interest) as String
        })
    }
    
    public func getPhoto() -> Data {
        updatePhoto(completion: {
            return (self.user.image) as Data
        })
    }
    
    func updatePersonalInfo() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser?.uid
        
        isLoading = true
        self.uploadImage(imageData: self.getPhoto(), path: "profile_Photos") { (url) in
            self.ref.collection("Users").document(uid ?? "").setData([
                            "uid": uid ?? "",
                            "imageurl": url,
                            "username": self.user.name,
                            "bio": self.user.bio,
                            "interest" : self.user.interest
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
    
    func increaseXPnLV() {
        //sending user data to Firebase
        let uid = Auth.auth().currentUser!.uid
        let docRef = ref.collection("Users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData(["xp": FieldValue.increment(Int64(50))])
                // update level
                let xp = document.data()!["xp"] as! Int
                docRef.updateData(["level": self.user.xp2Level(xp: xp)])
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func uploadImage(imageData: Data, path: String, completion: @escaping (String) -> ()){
        
        let storage = Storage.storage().reference()
        let uid = Auth.auth().currentUser?.uid
        
        storage.child(path).child(uid ?? "").putData(imageData, metadata: nil) { (_, err) in
            print("imageData: \(imageData)")
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
