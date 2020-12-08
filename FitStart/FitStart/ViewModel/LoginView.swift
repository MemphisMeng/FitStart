//
//  LoginView.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase
//Just testing out login Auth 
class LoginView : ObservableObject {
    @Published var code = ""
    @Published var number = ""
    @Published var errorMsg = ""
    @Published var error = false
    
    func verifyUser() {
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
            (ID, err) in
            if err != nil {
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                return
            }
            //Code sent
            
        }
    }
}

func alertView(completion: @escaping (String) -> ()) {
    let alert = UIAlertController(title: "Verification", message: "Enter Code", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    alert.addAction(UIAlertAction(title: "Verify", style: .default, handler: { (_) in
        completion(alert.textFields![0].text ?? "")
    }))
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
}
