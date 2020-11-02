//
//  ContentView.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/1/20.
//
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Task: Identifiable {
    var id: Int
    let message, imageName: String
}

var tabs = ["home", "meal", "fitness", "pal"]

struct TabButton : View {
    var image : String
    @Binding var selectedTab : String
    var body : some View {
        Button(action: {selectedTab = image}) {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color.blue.opacity(0.5) : Color.black.opacity(0.5))
                .frame(width: 40, height: 40)
                .padding()
        }
    
    }
        
    
}

struct ContentView: View {
    @State var selectedTab = "home"
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            //swich tabs
            TabView(selection: $selectedTab) {
                Home()
                    .tag("home")
                Meal()
                    .tag("meal")
                Fitness()
                    .tag("fitness")
                Pal()
                    .tag("pal")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
        
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) {image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    if image != tabs.last {
                        Spacer(minLength: 2)
                    }
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.blue.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.blue.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.blue.opacity(0.07).ignoresSafeArea(.all, edges: .all))
    }
    
}

struct Home: View {
    @State var txt = ""
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    let tasks: [Task] = [
            .init(id: 0, message: "Exercise for 20 minutes, following the cardio and arm animations", imageName: "Running"),
            .init(id: 1, message: "Drink 3 cups of water", imageName: "Drink_Water"),
            .init(id: 2, message: "Go to bed before 10 pm", imageName: "Exercise")
        ]
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 15) {
                    Text("Hello James").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Text("The secret of getting ahead is getting started.” – Mark Twain")
                }.foregroundColor(.black)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                VStack {
                    Button(action: {}) {
                        Image("addPeople")
                            .resizable()
                            .renderingMode(.original)
                            .overlay(Rectangle().stroke(Color.blue, lineWidth: 3))
                            .frame(width: 37, height: 37)
                    }.padding()
                    Button(action: {}) {
                        Image("profile")
                            .resizable()
                            .renderingMode(.original)
                            .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                            .frame(width: 45, height: 45)
                    }
                }
            }.padding()
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                VStack {
                    HStack{
                        Text("Daily Goals")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Text("View All")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    
                    Spacer(minLength: 15)
                    
                    HStack(spacing: 15) {
                        TextField("Add a goal...", text: $txt)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Rectangle())
                    
                    Spacer(minLength: 8)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1), spacing: 20) {
                        ForEach (tasks) { task in
                            TaskRow(task: task)
                        }
                    }
                        
                }
                .padding()
                .padding(.bottom,edge!.bottom + 70)
                
            }
//
        }
    }
}


struct TaskRow: View {
    let task: Task
    var body: some View {
        HStack {
            Image(task.imageName)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .frame(width: 45, height: 40)
            VStack (alignment: .leading) {
                Text(task.message).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct Meal: View {
    var body: some View {
        VStack {
            Text("Meal")
        }
    }
}

struct Fitness: View {
    var body: some View {
        VStack {
            Text("Fitness")
        }
    }
}

struct Pal: View {
    var body: some View {
        VStack {
            Text("Pal")
        }
    }
}



