//
//  Cube_one.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI
import AVKit
struct Cube_one: View {
    var width = UIScreen.main.bounds.width
    
    @State var data = [
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Jump Jacks", ofType: "mp4")!)), replay: false),
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Plank", ofType: "mp4")!)), replay: false),
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Squat", ofType: "mp4")!)), replay: false),
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Congratulations", ofType: "mp4")!)), replay: false),
    ]
    @State var index = 0
    var body: some View {
        
        TabView(selection: $index){
            ForEach(0..<data.count, id: \.self) { i in
                GeometryReader{ g in
                        ZStack{
                            Player(player: $data[i].player)
                                .tag(i)
                                .onChange(of: index) { (_) in
                                    for i in 0..<data.count {
                                        data[i].player.pause()
                                    }
                                    data[index].player.play()
                                }
                        }
                        .frame(width: g.frame(in: .global).width, height: g.frame(in: .global).height)
                        .rotation3DEffect(
                            .init(degrees: getAngle(xOffset: g.frame(in: .global).minX)),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            anchor: g.frame(in: .global).minX > 0 ? .leading: .trailing,
                            perspective: 2.5)
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
    
    
    }
    func getAngle(xOffset: CGFloat) -> Double {
        let tempAngle = xOffset / (width / 2)
        let rotationDegree : CGFloat = 25
        return Double(tempAngle * rotationDegree)
    }
}
                    

        


struct Cube_one_Previews: PreviewProvider {
    static var previews: some View {
        Cube_one()
    }
}



struct Video : Identifiable {
    var id : Int
    var player : AVPlayer
    var replay : Bool
}

struct Player : View {
    @Binding var player : AVPlayer
    var body : some View {
        VideoPlayer(player: player)
    }
}

