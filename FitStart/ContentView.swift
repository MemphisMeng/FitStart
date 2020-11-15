//
//  ContentView.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI
import CoreData

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

//struct Task: Identifiable {
//    var id: Int
//    let message, imageName: String
//}

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
//        UITextView.appearance().backgroundColor = UIColor.blue.cgColor
    }

    @State var centerX : CGFloat = 0
    @State var goToHome = false
//    @Environement(.verticalSizeClass) var size
    var body: some View {
        ZStack {
            if goToHome {
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
            
            } //end if
            else {
                OnBoardScreen()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for:Notification.Name("Success")), perform: {
            _ in withAnimation{self.goToHome = true}
        })
            
    }
        
}





//The Home page
struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @State var txt = ""
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "date",
                                                                            ascending: true)], animation: .spring()) var results : FetchedResults<Goal>
    var body: some View {
        ZStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                VStack{
                    HStack{
                        Text("Daily Goals")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("lightblue"))
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    ScrollView(.vertical, showsIndicators: true, content: {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(results){goal in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(goal.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(goal.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                            }
                        }
                        .padding()
                    })
                }
            })
            .sheet(isPresented: $homeData.isNewData, content: {
                NewDataView(homeData: homeData)
            })
            
            VStack{
                //for goals
                HStack{
                    Button(action: {homeData.isNewData.toggle()}, label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color("Color"))
                            .clipShape(Capsule())
                            .padding(.trailing)
                    })
                    .padding()
                    .sheet(isPresented: $homeData.isNewData, content: {
                        NewDataView(homeData: homeData)
                    })
                    .ignoresSafeArea(.all, edges: .top)
                }

            }
        }
        
        
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











