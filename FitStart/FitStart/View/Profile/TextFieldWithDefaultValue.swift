//
//  TextFieldWithDefaultValue.swift
//  FitStart
//
//  Created by Memphis Meng on 5/6/21.
//

import Foundation
import SwiftUI

struct TextFieldWithDefaultValue: View {

    var model: userViewModel    // Actual a more complex view model
    var textFieldName: String
    @State var editedValue: String

    init(model: userViewModel, text: String) {
        self.model = model
        self.textFieldName = text
        switch self.textFieldName {
        case "Name":
            self._editedValue = State(initialValue: self.model.getName())
        case "Bio":
            self._editedValue = State(initialValue: self.model.getBio())
        case "Interest":
            self._editedValue = State(initialValue: self.model.getInterest())
        default:
            self._editedValue = State(initialValue: "No records")
        }
    }
    
    var body: some View {
       TextField(textFieldName, text: $editedValue)
    }

}

