//
//  Fitness.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct Fitness: View {
    @Namespace var animation
    @State var show = false
    @State var selected : ExGoal!
    @State var homeActive = false
    var body: some View {
        NavigationView{
//            navigationBarBackButtonHidden(false)
            if show{
                    if (selected.image == "WeightLoss") {
                        Cube_one()
                    } else {
                        Cube_two()
                    }
                } else{
                        VStack{
                            VStack {
                                Image("FitMain")
                                    .resizable()
                                    .frame(width: 220, height: 150)
                                    .padding(.top, 80)
                                Text("Fitness")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color("5324FF"))
                                Text("What kind of exercise \n are you interested in?")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("C2C2C2"))
                            }.padding()
                            Spacer(minLength: 10)
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 15) {
                                    ForEach(exgoals) { item in
                                        CardView(card : item, animation: animation)
                                            .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                                            .onTapGesture {
                                                selected = item
                                                show = true
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 22)
                            }
                            .padding(.top)
                        }
                        .ignoresSafeArea(.all, edges: .all)
                   
                }
            
        }
        .navigationBarHidden(false)
    }
}


//Card view
struct CardView : View {
    var card : ExGoal
    var animation : Namespace.ID
    var body : some View {
        
        ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)){
            HStack(spacing: 15) {
               Spacer()
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .matchedGeometryEffect(id: card.image, in: animation)
                    
                Spacer(minLength: 0)
            }
            .frame(width: 250, alignment: .center)
            .padding(.bottom, 80)
            .background(Color("5324FF").opacity(0.8).cornerRadius(25).padding(.top, 35))
            .padding(.trailing, 8)
            .offset(x: 8)
//            .background(Color("purple").cornerRadius(25).padding(.top, 35))
            
            Text(card.title)
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(Color.white.opacity(0.9))
//                .padding(.vertical, 10)
                .frame(width: 258, height: 50, alignment: .center)
                .background(Color("8F66FF").opacity(0.8).cornerRadius(20))
                .offset(x:10)
                .offset(y:-2)
                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight], size: 30))
            
        }
    }
}




struct CustomCorner : Shape {
      
      var corners : UIRectCorner
      var size : CGFloat
      
      func path(in rect: CGRect) -> Path {
          
          let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
          
          return Path(path.cgPath)
      }
  }

//Two cards: Weight Loss and gain muscle
struct ExGoal : Identifiable {
    var id = UUID().uuidString
    var image : String
    var title : String
}

var exgoals = [
    ExGoal(image: "WeightLoss", title: "Weight Loss"),
    ExGoal(image: "Strength_03", title: "Gain Muscle")
]


//struct Fitness_Previews: PreviewProvider {
//    static var previews: some View {
//        Fitness()
//    }
//}

