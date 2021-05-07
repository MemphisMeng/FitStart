//
//  TextFieldWithDefaultValue.swift
//  FitStart
//
//  Created by Memphis Meng on 5/6/21.
//

import Foundation
import SwiftUI

struct TextFieldWithDefaultValue: View {

    var model:String    // Actual a more complex view model
    @State var editedValue: String

    init(model: String) {
        self.model = model
        self._editedValue = State(wrappedValue: model) // _editedValue is State<String>
    }
    
    var body: some View {
        TextField("Name", text: $editedValue)
    }

}

struct Check: View {
    
    @StateObject var originalData = DBDownloaderViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 15) {
                    Text("User Info")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
//                Text(originalData.currentName!)
                HStack (spacing: 15){
                    TextFieldWithDefaultValue(model: originalData.currentName ?? "No name is catched")
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
            }
        }
    }
}

struct textFieldwithDefault_Previews: PreviewProvider {
    static var previews: some View {
        Check()
    }
}
