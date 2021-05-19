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
    @StateObject var user: userViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            HStack {
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(user: user)
            } else {
                RegisterUser(currentUser: user)
            }
        })
        .padding()
    }
}

//struct CustomProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(, user: <#currentUserViewModel#>)
//    }
//}
