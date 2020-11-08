//
//  ExAnimation.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct ExAnimation: View {
    
    @Binding var exercise : ExerciseModel!
    @Binding var show: Bool
    var animation: Namespace.ID
    // Initialization....
    @State var selectedColor = Color.red
    
    @State var count = 0
    
    @State var isSmallDevice = UIScreen.main.bounds.height < 750
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                VStack(alignment: .leading,spacing: 5){
                    
                    Button(action: {
                        
                        withAnimation(.easeOut){show.toggle()}
                        
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    
                    Text(exercise.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            HStack(spacing: 10){
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("XP")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(String(exercise.xp))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                
                Image(exercise.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // Hero Animation...
                    .matchedGeometryEffect(id: exercise.image, in: animation)
            }
            .padding()
            .padding(.top,10)
            .zIndex(1)

            VStack{
                
                ScrollView(isSmallDevice ? .vertical : .init(), showsIndicators: false) {
                    
                    HStack{
                        Spacer(minLength: 0)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Durantion")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("10 min")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("Weight training is a common type of strength training for developing the strength and size of skeletal muscles. ")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    HStack(spacing: 20){
                        
                        Button(action: {}) {
                            Image(systemName: "suit.heart.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                }
                .padding(.top,isSmallDevice ? 0 : -20)
            }
            .background(
                Color.blue
                    .clipShape(CustomCorner())
                    .padding(.top,isSmallDevice ? -60 : -100)
            )
            .zIndex(0)
        }
        .background(Color(exercise.image).ignoresSafeArea(.all, edges: .top))
        .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
        .onAppear {
            
            // First Color Is Image Or Bag Color...
            selectedColor = Color(exercise.image)
        }
    }
}
struct CustomCorner : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}
//struct ExAnimation_Previews: PreviewProvider {
//    static var previews: some View {
//        ExAnimation()
//    }
//}
