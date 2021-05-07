//
//  Pal.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct Pal: View {
    @AppStorage("status") var status = false
    var body: some View {
        NavigationView{
            VStack{
                if status{
//                    RegisterUser()
                    ProfileView()
                }
                else{
                    Profile()
                }
            }
            .navigationBarHidden(true)
            
        }
    }
}

struct Pal_Previews: PreviewProvider {
    static var previews: some View {
        Pal()
    }
}
