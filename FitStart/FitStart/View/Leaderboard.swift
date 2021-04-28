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
    @ObservedObject private var users = UserViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Level \(users.currentUser.level)")
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .background(Color("Black"))
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.leading)
                Image("Badge")
                    .resizable()
                    .frame(width: 20, height: 24, alignment: .leading)
                Spacer()
                Text("xp: \(users.currentUser.xp)")
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .background(Color("Black"))
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.trailing)
            }
            .padding(.top)
            Text("User Leaderboard")
            VStack {
                HStack {
                    Text("User Name")
                    Text("XP")
                }
            }
            List(users.topFiveUsers) {
                user in
                VStack {
                    HStack {
                        Text(verbatim: user.name)
                        Text(verbatim: String(user.xp))
                    }
                }
            }
            Spacer()
        }
        .background(Color.white)
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
