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

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
