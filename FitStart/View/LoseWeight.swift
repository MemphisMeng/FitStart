//
//  LoseWeight.swift
//  FitStart
//
//  Created by vivian on 11/14/20.
//

import SwiftUI

struct LoseWeight: View {
    @Binding var goal : ExGoal!
    @Binding var show : Bool
    var animation: Namespace.ID
    @State var isSmallDevice = UIScreen.main.bounds.height < 750
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Button(action: {
                    withAnimation(.easeOut) {
                        show.toggle()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
            }
            .padding()
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            Spacer(minLength: 0)
        }
        .background(Color("Color").ignoresSafeArea(.all, edges: .top))
        .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
    }
}

//struct LoseWeight_Previews: PreviewProvider {
//    static var previews: some View {
//        LoseWeight()
//    }
//}
