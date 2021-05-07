//
//  MemphisProfileView.swift
//  FitStart
//
//  Created by Memphis Meng on 5/5/21.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            HStack {
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary()
            } else {
                RegisterUser()
            }
            
        })
        .padding()
    }
}

struct CustomProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
