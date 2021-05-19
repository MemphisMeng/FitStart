//
//  UserInfoModel.swift
//  FitStart
//
//  Created by Memphis Meng on 5/7/21.
//

import Foundation
import SwiftUI
import Firebase

struct userModel {
    var uid = UUID()
    var name = ""
    var bio = ""
    var interest = ""
    var level = 1
    var xp = 0
    var email = ""
    var image: Data = Data(count: 0)
    
    init() {
        
    }
    
    init(_ name:String, _ xp: Int) {
        self.name = name
        self.xp = xp
        self.level = self.xp2Level(xp: xp)
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
}
