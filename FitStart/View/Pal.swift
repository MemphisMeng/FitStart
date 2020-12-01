//
//  Pal.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct Pal: View {
    var body: some View {
        NavigationView{
            RegisterUser()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}

struct Pal_Previews: PreviewProvider {
    static var previews: some View {
        Pal()
    }
}
