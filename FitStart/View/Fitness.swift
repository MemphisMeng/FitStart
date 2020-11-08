//
//  Fitness.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct Fitness: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Fitness").font(.largeTitle)
                }.foregroundColor(.blue)
            }
            Spacer()
            SearchView().padding(.vertical, 15)

        }
    }
}

struct SearchView : View {
    @State var txt = ""
    @State var selected = scroll_Tabs[0]
    @Namespace var animation
    @State var show = false
    @State var selectedExercise : ExerciseModel!
    var body : some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing : 15) {
                    Image(systemName: "magnifyingglass").font(.body)
                    TextField("Search Exercise", text: $txt)
                }.padding()
                .foregroundColor(.black)
                .cornerRadius(25)
            
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        HStack {
                            Text("Animations")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 20) {
                                ForEach(scroll_Tabs, id: \.self) {tab in
                                    tabButton(title:tab, selected: $selected, animation: animation)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                        })
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
                            ForEach(animations) {i in
                                AniView(aniData: i, animation: animation)
                                    .onTapGesture{
                                        withAnimation(.easeIn) {
                                            selectedExercise = i
                                            show.toggle()
                                        }
                                    }
                            
                            }
                        }
                        .padding()
                        .padding(.top, 10)
                    }
                })
            }
            .background(Color("lighblue").opacity(0.1).ignoresSafeArea(.all, edges: .all))
            
            if selected != "" && show {
                ExAnimation(exercise: $selectedExercise, show: $show, animation: animation)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        
    }
}

struct tabButton : View {
    var title : String
    @Binding var selected : String
    var animation : Namespace.ID
    var body : some View {
        Button(action: {
            withAnimation(.spring()){
                selected = title
            }
            
        }, label: {
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selected == title ? .blue : .gray)
                if selected == title {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 50, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
                
            })
        })
    }
}

struct AniView : View {
    var aniData : ExerciseModel
    var animation : Namespace.ID
    var body : some View {
        VStack(alignment: .leading, spacing: 6){
            ZStack{
                
                Color(aniData.image)
                    .cornerRadius(15)
                Image(aniData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: aniData.image, in: animation)
            }
            Text(aniData.title)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            Text(String(aniData.xp))
                .fontWeight(.heavy)
                .foregroundColor(.black)
        }

    }
 
}


struct Fitness_Previews: PreviewProvider {
    static var previews: some View {
        Fitness()
    }
}

