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

var tabs = ["Leaderboard", "home", "profile"]

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var centerX : CGFloat = 0
    @State var goToHome = false
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
//    @Environement(.verticalSizeClass) var size
    var body: some View {
        
        ZStack {
            if goToHome {
                
                NavigationView {
                    CustomTabView(centerX: $centerX)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                }
            }
            else {
                OnBoardScreen()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for:Notification.Name("Success")), perform: {
            _ in withAnimation{self.goToHome = true}
        })
    }
        
}

struct CustomTabView : View {
    //swich tabs
    @State var selectedTab = "home"
    @Binding var centerX : CGFloat
    var body : some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView(selection: $selectedTab) {
                Home()
                    .tag("home")
                Leaderboard()
                    .tag("Leaderboard")
                Pal()
                    .tag("profile")
            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .all)
            
//            Spacer()
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
//            .padding(.top)
            .padding(.vertical, 17)
            .padding(.bottom, 20)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15: 0)
            .background(Color("5324FF").clipShape(AnimatedShape(centerX: centerX)))
            .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 0, y: -5)
//            .ignoresSafeArea(.all, edges: .all)
        }
        .ignoresSafeArea(.all, edges: .all)
           
    }
}

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
                    .foregroundColor(selectedTab == image ?  Color.white.opacity(0.9) : Color("8F66FF").opacity(0.6) )
                    
                Text(image)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .opacity(selectedTab == image ? 1 : 1)
            }
//            .padding(.top)
            .frame(width: 70, height: 50)
            //pop the icon selected
            .offset(y: selectedTab == image ? -5 : 0)
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
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .background(Color("Black"))
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.leading)
                Image("Badge")
                    .resizable()
                    .frame(width: 20, height: 24, alignment: .leading)
                
                Spacer()
                Text("xp: 450")
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .background(Color("Black"))
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                    .padding(.trailing)
            }
            .padding(.top)
//            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 10) {
                ForEach(mainfs) { f in
                    if (f.name == "Goals") {
                        NavigationLink(destination: Goals()) {
                            mainFeatureView(feature: f)
                        }
                    } else if (f.name == "Fitness") {
                        NavigationLink(destination: Fitness()) {
                            mainFeatureView(feature: f)
                        }
                    } else if (f.name == "Diet"){
                        NavigationLink(destination: Meal()) {
                            mainFeatureView(feature: f)
                        }
                    } else if (f.name == "Fitpal") {
                        NavigationLink(destination: FitPal()) {
                            mainFeatureView(feature: f)
                        }
                    }
                }
                .padding(.top)
            }
            
            Spacer()
    
        }
        .background(Color.white)
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
                if (feature.name == "Goals") {
                
                }
                
            }) {
                Text(feature.name)
                    .font(.title2)
                    .bold()
                    .padding(.vertical, 5)
                    .padding(.leading)
                    .padding(.trailing)
                    .foregroundColor(.white)
            }
            .background(LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
    MainFeature(name: "Diet"),
    MainFeature(name: "Fitpal")
]









