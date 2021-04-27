//
//  Leaderboard.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI

struct Leaderboard: View {
    var body: some View {
        Image("leaderboardUI")
            .resizable()
            .scaledToFill()
//        .ignoresSafeArea(.all, edges: .all)

    }
}

//struct Leaderboard: View {
//    @ObservedObject private var users = UserViewModel()
//    var body: some View {
//        VStack {
//            HStack {
//                // TODO
//                Text("Level 1")
//                    .fontWeight(.bold)
//                    .padding(.horizontal)
//                    .foregroundColor(Color.white)
//                    .background(Color("Black"))
//                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
//                    .padding(.leading)
//                Image("Badge")
//                    .resizable()
//                    .frame(width: 20, height: 24, alignment: .leading)
//
//                Spacer()
//                Text("xp: \(users.xp ?? 0)")
////                    Text("xp: 1500")
//                    .fontWeight(.bold)
//                    .padding(.horizontal)
//                    .foregroundColor(Color.white)
//                    .background(Color("Black"))
//                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
//                    .padding(.trailing)
//            }
//            .padding(.top)
//
////            ForEach(0..<5) {
////                user in
////                    Text(verbatim: users.users[user][1])
////                    Text(verbatim: users.users[user][0])
////                    .font(.subheadline)
////            }
//            Spacer()
//        }
//        .background(Color.white)
//    }
//}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
