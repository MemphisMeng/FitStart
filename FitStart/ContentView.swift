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


//Button for the Bottom Menu Bar
struct TabButton : View {
    var image : String
    @Binding var centerX : CGFloat
    var rect : CGRect
    @Binding var selectedTab : String
    
    var body : some View {
        
        Button(action: {withAnimation(.spring()){
            selectedTab = image
            centerX = rect.midX
            }
        }, label: {
            VStack {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedTab == image ? Color.blue.opacity(0.5) : Color.black.opacity(0.4))
                    
                Text(image)
                    .font(.caption)
                    .foregroundColor(.black)
                    .opacity(selectedTab == image ? 1 : 0)
            }
            .padding(.top)
            .frame(width: 70, height: 50)
            //pop the icon selected
            .offset(y: selectedTab == image ? -15 : 0)
            
        })
    
    }
        
    
}

struct ContentView: View {
    @State var selectedTab = "home"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var centerX : CGFloat = 0
//    @Environement(.verticalSizeClass) var size
    var body: some View {
            //swich tabs
            VStack(spacing: 0) {
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
            
            
            //for menu bar
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) {image in
                    GeometryReader {reader in
                        TabButton(image: image, centerX: $centerX, rect:reader.frame(in:.global), selectedTab: $selectedTab)
                        //setting initial curve
                            .onAppear(perform: {
                                if image == tabs.first{
                                    centerX = reader.frame(in: .global).midX
                                }
                            })
                            
                    }
                    .frame(width: 70, height: 50)
                    if image != tabs.last {Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 25)
            .padding(.top)
                //For Smaller size iphone padding will be 15
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15:
                            UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white.clipShape(AnimatedShape(centerX: centerX)))
            .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 0, y: -5)
            .padding(.top, -15)
            .ignoresSafeArea(.all, edges: .horizontal)
        }
        .background(Color.blue.opacity(0.07).ignoresSafeArea(.all, edges: .bottom))
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
            //for goals
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

//The task list
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

//The Custom shape for poping up the Icon in the Menu Bar upon selection
struct AnimatedShape: Shape {
    var centerX : CGFloat
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x:0, y:15))
            path.addLine(to: CGPoint(x:0, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:15))
            
            //curve
            path.move(to: CGPoint(x: centerX - 35, y:15))
            path.addQuadCurve(to: CGPoint(x: centerX + 35, y:15), control: CGPoint(x:centerX, y:-30))
        }
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



