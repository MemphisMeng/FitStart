//
//  FBAuth.swift
//  FitStart
//
//  Created by Memphis Meng on 4/19/21.
//

import SwiftUI
import FirebaseAuth
import CryptoKit
import AuthenticationServices

// This typeAlias is defined just to make it simpler to deal with the tuble used in the SignInWithApple handle function once signed in.
typealias SignInWithAppleResult = (authDataResult: AuthDataResult, appleIDCredential: ASAuthorizationAppleIDCredential)

struct FBAuth {
    
    // MARK: - Sign In with Email functions
    
    static func resetPassword(email:String, resetCompletion:@escaping (String,String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion("Reset Failed", error.localizedDescription)
            } else {
                resetCompletion("","Success. Reset email sent successfully, Check your email")
            }
        }
        )}
    
    
    static func authenticate(withEmail email :String,
                             password:String,
                             completionHandler:@escaping (Result<Bool, EmailAuthError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // check the NSError code and convert the error to an AuthError type
            var newError:NSError
            if let err = error {
                newError = err as NSError
                var authError:EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError!))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    

    // MARK: - FB Firestore User creation
    static func createUser(withEmail email:String,
                           fullName: String,
                           password:String,
                           completionHandler:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                completionHandler(.failure(err))
                return
            }
            guard let _ = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            
            var data: [String: Any]
            
            if fullName != "" {
                data = [
                    FBKeys.User.uid: authResult!.user.uid,
                    FBKeys.User.name: fullName,
                    FBKeys.User.email: authResult!.user.email!
                ]
            } else {
                data = [
                    FBKeys.User.uid: authResult!.user.uid,
                    FBKeys.User.email: email
                ]
            }
            
            FBFirestore.mergeFBUser(data, uid: authResult!.user.uid) { (result) in
                completionHandler(result)
            }
            completionHandler(.success(true))
        }
    }
    
    // MARK: - Logout
    
    static func logout(completion: @escaping (Result<Bool, Error>) -> ()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }
    
}
