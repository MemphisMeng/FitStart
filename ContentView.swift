//
//  ContentView.swift
//  Fit+Fit
//
//  Created by Mark Tony on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("The Journey of a Thousand Miles begins with a Single Step - Mark Tony")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
