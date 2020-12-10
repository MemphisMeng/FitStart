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
//            Color("5182FF")
//                .ignoresSafeArea(.all, edges: .all)
            LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .top, endPoint: .bottomTrailing)
                .cornerRadius(10)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer(minLength: 0)
               
                Text("What hurt today makes you stronger tomorrow.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("-- Jay Cutler")
                    .font(.body)
                    .fontWeight(.semibold)
                    .italic()
                    .foregroundColor(.white)
                    .padding()
                    .padding(.bottom)
                    .frame(alignment: .trailing)
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
                            .fill(LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: calculateWidth() + 65)
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        ZStack {
                            Image(systemName: "chevron.right")
                            Image(systemName: "chevron.right")
                                .offset(x: -12)
                            
                        }
                        .foregroundColor(.white)
                        .offset(x:8)
                        .frame(width: 65, height: 65)
                        .background(LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
