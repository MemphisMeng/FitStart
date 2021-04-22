//
//  FBUser.swift
//  FitStart
//
//  Created by Memphis Meng on 4/19/21.
//

import Foundation

struct FBUser: Identifiable {
    let id = UUID()
    let uid: String
    let name: String
    let email: String
    let xp: Int
}

extension FBUser: DocumentSerializable {
    
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let name = documentData[FBKeys.User.name] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
        let xp = documentData[FBKeys.User.xp] as? String ?? "0"
        
        self.init(uid: uid,
                  name: name,
                  email: email,
                  xp: (xp as NSString).integerValue)
    }
}

