//
//  OnBoardScreen.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct OnBoardScreen: View {
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset : CGFloat = 0
    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer(minLength: 0)
                Text("Motivational Quote")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text("A positive attitude gives you power over your circumstances instead of your circumstances having power over you.")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.bottom)
                //                Image("Quote")
                Spacer(minLength: 0)
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                    Text("SWIPE TO START")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                    //background progress
                    HStack {
                        Capsule()
                            .fill(Color("red"))
                            .frame(width: calculateWidth() + 65)
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        ZStack {
                            Image(systemName: "chevron.right")
                            Image(systemName: "chevron.right")
                                .offset(x: -10)
                        }
                        .foregroundColor(.white)
                        .offset(x:10)
                        .frame(width: 65, height: 65)
                        .background(Color("red"))
                        .clipShape(Circle())
                        .offset(x: offset)
                        .gesture(DragGesture().onChanged(onChange(value:))
                                    .onEnded(onEnd(value:)))
                        
                        
                        Spacer()
                    }
                }
                .frame(width: maxWidth, height: 65)
                .padding(.bottom)
            }
        }
    }
    func calculateWidth() -> CGFloat {
        let percent = offset/maxWidth
        return percent * maxWidth
    }
    
    
    func onChange(value: DragGesture.Value) {
        if value.translation.width > 0 && offset <= maxWidth - 65 {
            offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(Animation.easeOut(duration: 0.3)) {
            if offset > 180 {
                offset = maxWidth - 65
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
            } else {
                offset = 0
            }
        }
    }
}

struct OnBoardScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardScreen()
    }
}
