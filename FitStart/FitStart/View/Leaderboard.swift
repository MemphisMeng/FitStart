//
//  Leaderboard.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI

//struct Leaderboard: View {
//    var body: some View {
//        Image("leaderboardUI")
//            .resizable()
//            .scaledToFill()
////        .ignoresSafeArea(.all, edges: .all)
//
//    }
//}

struct Leaderboard: View {
    @StateObject private var leadUsers = topUsersViewModel()
    @StateObject var currentUser: userViewModel
    var body: some View {
        Text("Hello World!")
//        VStack {
//            HStack {
//                Text("Level \(currentUser.getLevel())")
//                    .fontWeight(.bold)
//                    .padding(.horizontal)
//                    .foregroundColor(Color.white)
//                    .background(Color("Black"))
//                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
//                    .padding(.leading)
//                Image("Badge")
//                    .resizable()
//                    .frame(width: 20, height: 24, alignment: .leading)
//                Spacer()
//                Text("xp: \(currentUser.getXP())")
//                    .fontWeight(.bold)
//                    .padding(.horizontal)
//                    .foregroundColor(Color.white)
//                    .background(Color("Black"))
//                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
//                    .padding(.trailing)
//            }
//            .padding(.top)
//            Text("User Leaderboard")
//            Form {
//                VStack {
//                    HStack {
//                        Text("User Name")
//                            .font(.headline)
//                        Divider()
//                        Text("XP")
//                            .font(.headline)
//                    }
//                }
//                List(leadUsers.getTopUsers()) {
//                    user in
//                    VStack {
//                        HStack {
//                            Text(verbatim: user.name)
//                            Divider()
//                            Text(verbatim: String(user.xp))
//                        }
//                    }
//                }
//            }
//            Spacer()
//        }
//        .background(Color.white)
    }
}

//struct Leaderboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Leaderboard()
//    }
//}
