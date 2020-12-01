//
//  RegisterViewModel.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject {
    @Published var name = ""
    @Published var bio = ""
    @Published var interest = ""
    @Published var level = 0
    @Published var xp = 0
    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    
    func register() {
        
    }
}
