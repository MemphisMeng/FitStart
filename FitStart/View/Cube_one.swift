//
//  Cube_one.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI

struct Cube_one: View {
    var width = UIScreen.main.bounds.width
    var body: some View {
        TabView {
            ForEach(data) { story in
                GeometryReader{ g in
                    ZStack{
                        LinearGradient(gradient: .init(colors: [Color("Color"), story.color]), startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                        Image(story.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: story.offset, height: 2.5)
                            })
                            HStack(spacing: 12) {
                                Image(story.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(story.name)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text(String(story.time))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.all)
                        
                    }
                    .frame(width: g.frame(in: .global).width, height: g.frame(in: .global).height)
                    .rotation3DEffect(
                        .init(degrees: getAngle(xOffset: g.frame(in: .global).minX)),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: g.frame(in: .global).minX > 0 ? .leading: .trailing,
                        perspective: 2.5)
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

struct Story : Identifiable {
    var id = UUID().uuidString
    var story : String
    var name : String
    var time : Int
    var offset : CGFloat
    var color : Color
}


//exercises images for now
var data = [
    Story(story: "p1", name: "Jumping Jacks", time: 2, offset: 50, color: Color.yellow),
    Story(story: "p2", name: "Plank", time: 2, offset: 100, color: Color.yellow),
    Story(story: "p3", name: "Squat", time: 2, offset: 150, color: Color.black),
    Story(story: "p4", name: "Bicycle Crunch", time: 2, offset: 200, color: Color.gray),
    Story(story: "p5", name: "Congratulations!", time: 2, offset: 250, color: Color.purple),
    Story(story: "p6", name: "Locked", time: 0, offset: 300, color: Color.gray)
]
