//
//  Goal.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI
import CoreData

struct Goals: View {
    @StateObject var homeData = HomeViewModel()
    @State var txt = ""
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "date",
                                                                            ascending: true)], animation: .spring()) var results : FetchedResults<Goal>
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var greeting : String = "Hello"
    @Environment(\.managedObjectContext) var context
    var body: some View {
        ZStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                VStack{
                    HStack{
                        Text("Daily Goals")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .foregroundColor(Color("lightblue"))
                            .onAppear(perform: convertDate)
                        Spacer()
                        Button(action: {homeData.isNewData.toggle()}, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(width: 30, height: 30)
                                .background(Color("Color"))
                                .clipShape(Capsule())
                                .padding(.trailing)
                            
                        })
                        .padding()
                        .sheet(isPresented: $homeData.isNewData, content: {
                            NewDataView(homeData: homeData)
                        })
                    }
                    .padding(.top, 40)
                    .ignoresSafeArea(.all, edges: .all)
                    
                  
                    Text(greeting)
                        .bold()
                        .font(.title3)
                        .italic()
                        .padding(.top, -30)
                        .padding(.horizontal)
                        
        
                    ScrollView(.vertical, showsIndicators: true, content: {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(results){goal in
                                HStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(Color("Color"))
                                        .contextMenu{
                                            Button(action: {
                                                context.delete(goal)
                                                try! context.save()
                                            }, label: {
                                                Text("Mark Complete")
                                            })
                                        }
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        Text(goal.content ?? "")
                                            .fontWeight(.bold)
                                        Text(goal.date ?? Date(), style: .date)
                                            .fontWeight(.semibold)
                                    })
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        Button(action: {
                                            homeData.EditItem(item: goal)
                                        }, label: {
                                            Text("Edit")
                                        })
                                    }
                                }
                                
                            }
                        }
                        .padding()
                    })
                }
            })
            .sheet(isPresented: $homeData.isNewData, content: {
                NewDataView(homeData: homeData)
            })
        }
        .navigationBarHidden(true)
    }
    
    func convertDate() {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 :greeting = "Good Morning! Bonjour"
        case 12 : greeting = "Hey it's already noon, take a break!"
        case 13..<17 : greeting = "Good afternoon. Keep up with the hard work"
        case 17..<24 : greeting = "You are almost done for the day. Sit back and relax!"
        default:
            greeting = "Hello"
        }
    }
}


