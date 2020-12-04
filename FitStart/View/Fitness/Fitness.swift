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
    var body: some View {
        NavigationView{
            VStack{
                if show{
                    if (selected.image == "WeightLoss") {
                        Cube_one()
                    } else {
                        Cube_two()
                    }
                } else{
                    ZStack{
                        VStack{
                            VStack {
                                Image("WeightLoss_04")
                                    .resizable()
                                    .frame(width: 80, height: 65)
                                Text("Fitness")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color("purple"))
                                Text("What kind of exercise are you interested in")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
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
//                        if selected != nil && show {
//                            LoseWeight(goal: $selected, show: $show, animation: animation)
//                        }
                    }
                    .ignoresSafeArea(.all, edges: .all)
                }
            }
        }
        .navigationBarHidden(true)
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
                    .frame(height: 100, alignment: .center)
                    .matchedGeometryEffect(id: card.image, in: animation)
                    
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .padding(.bottom, 80)
            .background(Color("Color").cornerRadius(25).padding(.top, 35))
            .padding(.trailing, 8)
            .background(Color("purple").cornerRadius(25).padding(.top, 35))
            
            Text(card.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
//                .padding(.vertical, 10)
                .frame(width: 340, height: 30, alignment: .center)
                .background(Color("purple"))
                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight], size: 10))
            
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

