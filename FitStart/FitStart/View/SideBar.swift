//
//  SideBar.swift
//  FitStart
//
//  Created by Minglan  on 12/4/20.
//

import SwiftUI
//Not used in this version (Can be used to provide
//customizing features and faster way back to the homepage
struct SideBar: View {
    @State var index = 0
    @State var show = false
    @State var centerX : CGFloat = 0
          var body: some View{
              ZStack{
                  // Menu...
                  HStack{
                      
                      VStack(alignment: .leading, spacing: 12) {
                          
                          Image("Profile")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.horizontal)
                          
                          Text("Hey")
                              .font(.title)
                              .fontWeight(.bold)
                              .foregroundColor(.white)
                              .padding(.top, 10)
                            .padding(.horizontal)
                          
                          Text("Catherine")
                              .fontWeight(.bold)
                              .font(.title)
                              .foregroundColor(.white)
                            .padding(.horizontal)
                          
                          Button(action: {
                              
                              self.index = 0
                              
                              // animating Views...
                              
                              // Each Time Tab Is Clicked Menu Will be Closed...
                              withAnimation{
                                  
                                  self.show.toggle()
                              }
                              
                          }) {
                              
                              HStack(spacing: 25){
                                  
                                  Image("main")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.index == 0 ? Color("Color1") : Color.white)
      
                                  
                                  Text("main")
                                  .foregroundColor(self.index == 0 ? Color("Color1") : Color.white)
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal)
                              .background(self.index == 0 ? Color("Color1").opacity(0.2) : Color.clear)
                              .cornerRadius(10)
                          }
                          .padding(.top,25)
                          
                          Button(action: {
                              
                              self.index = 1
                              
                              withAnimation{
                                  
                                  self.show.toggle()
                              }
                              
                          }) {
                              
                              HStack(spacing: 25){
                                  
                                  Image("bell")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.index == 1 ? Color("Color1") : Color.white)
      
                                  
                                  Text("fitness")
                                  .foregroundColor(self.index == 1 ? Color("Color1") : Color.white)
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal)
                              .background(self.index == 1 ? Color("Color1").opacity(0.2) : Color.clear)
                              .cornerRadius(10)
                          }
                          
                          Button(action: {
                              
                              self.index = 2
                              
                              withAnimation{
                                  
                                  self.show.toggle()
                              }
                              
                          }) {
                              
                              HStack(spacing: 25){
                                  
                                  Image("meal")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.index == 2 ? Color("Color1") : Color.white)
      
                                  
                                  Text("meal")
                                  .foregroundColor(self.index == 2 ? Color("Color1") : Color.white)
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal)
                              .background(self.index == 2 ? Color("Color1").opacity(0.2) : Color.clear)
                              .cornerRadius(10)
                          }
                          
                          Button(action: {
                              
                              self.index = 3
                              
                              withAnimation{
                                  
                                  self.show.toggle()
                              }
                              
                          }) {
                              
                              HStack(spacing: 25){
                                  
                                  Image("My Goals")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.index == 3 ? Color("Color1") : Color.white)
      
                                  
                                  Text("My Goals")
                                  .foregroundColor(self.index == 3 ? Color("Color1") : Color.white)
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal)
                              .background(self.index == 3 ? Color("Color1").opacity(0.2) : Color.clear)
                              .cornerRadius(10)
                          }
                          
//                          Divider()
//                              .frame(width: 150, height: 1)
//                              .background(Color.white)
//                              .padding(.vertical,30)
//
//                          Button(action: {
//
//
//                          }) {
//
//                              HStack(spacing: 25){
//
//                                  Image("out")
//                                      .foregroundColor(Color.white)
//
//
//                                  Text("Sign Out")
//                                  .foregroundColor(Color.white)
//                              }
//                              .padding(.vertical, 10)
//                              .padding(.horizontal)
//                          }
//
//                          Spacer(minLength: 0)
//                      }
//                      .padding(.top,25)
//                      .padding(.horizontal,20)
                      
                      Spacer(minLength: 0)
                  }
                  .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                  .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                  
                  // MainView...
                  
                  VStack(spacing: 0){
                      
                      HStack(spacing: 15){
                          
                          Button(action: {
                              
                              withAnimation{
                                  
                                  self.show.toggle()
                              }
                              
                          }) {
                              
                              // close Button...
                              
                              Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                                  .resizable()
                                  .frame(width: self.show ? 18 : 22, height: 18)
                                  .foregroundColor(Color.black.opacity(0.4))
                          }
                          
                          // Changing Name Based On Index...
                          
                          Text(self.index == 0 ? "main" : (self.index == 1 ? "fitness" : (self.index == 2 ? "meal" : "My Goals")))
                              .font(.title)
                              .foregroundColor(Color.black.opacity(0.6))
                          
                          Spacer(minLength: 0)
                      }
                      .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                      .padding()
                      
                      GeometryReader{_ in
                          
                          VStack{
                              
                              // Changing Views Based On Index...
                              
                              if self.index == 0{
                                  
                                NavigationView {
                                    CustomTabView(centerX: $centerX)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .navigationBarHidden(true)
                                }
                              }
                              else if self.index == 1{
                                  
                                  Fitness()
                              }
                              else if self.index == 2{
                                  
                                  Meal()
                              }
                              else{
                                  
                                  Goals()
                              }
                          }
                      }
                  }
                  .background(Color.white)
                  //Applying Corner Radius...
                  .cornerRadius(self.show ? 30 : 0)
                  // Shrinking And Moving View Right Side When Menu Button Is Clicked...
                  .scaleEffect(self.show ? 0.9 : 1)
                  .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
                  // Rotating Slighlty...
                  .rotationEffect(.init(degrees: self.show ? -5 : 0))
                  
              }
              .background(Color("Color").edgesIgnoringSafeArea(.all))
              .edgesIgnoringSafeArea(.all)
          }
        }
}



