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

var tabs = ["Leaderboard", "home", "Profile"]


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
                    .foregroundColor(selectedTab == image ? Color.yellow.opacity(0.8) : Color.white.opacity(0.9))
                    
                Text(image)
                    .font(.caption)
                    .foregroundColor(.black)
                    .opacity(selectedTab == image ? 1 : 0)
            }
            .padding(.top)
            .frame(width: 70, height: 50)
            //pop the icon selected
            .offset(y: selectedTab == image ? -5 : 0)
            
            
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
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
//    @Environement(.verticalSizeClass) var size
    var body: some View {
        ZStack {
            if goToHome {
                
                //swich tabs
                VStack(spacing: 0) {
                   
                        TabView(selection: $selectedTab) {
                            Home()
                                .tag("home")
                            Leaderboard()
                                .tag("Leaderboard")
                            Pal()
                                .tag("Profile")
                        }
//                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
           
                    
                    
                //for menu bar
                Spacer(minLength: 0)
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
                        .frame(width: 50, height: 30)
                        if image != tabs.last {Spacer(minLength: 0)}
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top)
//                .padding(.bottom)
                    //For Smaller size iphone padding will be 15
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15:
                                UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(Color("Color").clipShape(AnimatedShape(centerX: centerX)))
                .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 0, y: -5)
//                .padding(.top, -5)
                .ignoresSafeArea(.all, edges: .all)
            }
            .background(Color.white.ignoresSafeArea(.all, edges: .all))
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
    var body: some View {
        VStack {
            HStack {
                Text("Level 1")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.leading)
                Image("Badge")
                    .resizable()
                    .frame(width: 20, height: 24, alignment: .leading)
                
                Spacer()
                Text("xp: 1500")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.trailing)
            }
          
        
            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 2), spacing: 10) {
                ForEach(mainfs) { f in
                   
                        mainFeatureView(feature: f)
                    
                    
                }
                .padding(.top)
            }
            
            Spacer()
    
        }
    }
}

struct mainFeatureView : View {
    var feature : MainFeature
    var body : some View {
        VStack {
            Image(feature.name)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(.top)
                .padding(.leading, 15)
            
            Button(action: {
               
            }) {
                Text(feature.name)
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                    .padding(.trailing)
                    .foregroundColor(.white)
            }
            .background(Color("Color"))
            .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 5))
            .padding(.top, 20)
        }
    }
}

//The Custom shape for poping up the Icon in the Menu Bar upon selection
struct AnimatedShape: Shape {
    var centerX : CGFloat
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x:0, y:10))
            path.addLine(to: CGPoint(x:0, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:10))
            
            //curve
            path.move(to: CGPoint(x: centerX - 15, y:10))
            path.addQuadCurve(to: CGPoint(x: centerX + 35, y:10), control: CGPoint(x:centerX, y:-20))
        }
    }
    
}

struct MainFeature : Identifiable {
    var id = UUID().uuidString
    var name : String
//    var image: String
}

var mainfs = [
    MainFeature(name: "Fitness"),
    MainFeature(name: "Goals"),
    MainFeature(name: "Diet")
]









