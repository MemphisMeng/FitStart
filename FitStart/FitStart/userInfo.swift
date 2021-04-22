//
//  userInfo.swift
//  FitStart
//
//  Created by Memphis Meng on 4/19/21.
//

import SwiftUI
import FirebaseAuth

enum FBAuthState {
    case undefined, signedOut, signedIn
}

class UserInfo: ObservableObject {
    var devMode = false
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var user: FBUser = FBUser(uid: "", name: "", email: "", xp: 0)
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    // Mark: - Auth
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            guard let user = user else {
//                print("User is signed out")
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
//            print("Welcome \(user.name)!")
            print("Successfully authenticated user with uid: \(user.uid)")
            print("Your email addres is: \(String(describing: user.email))")
        })
    }
}

