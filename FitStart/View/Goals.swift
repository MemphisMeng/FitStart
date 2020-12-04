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
            
            VStack{
                //for goals
                Spacer(minLength: 2)
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
                .onAppear(perform: convertDate)
                
                ZStack{
                    Text(greeting)
                }
                
            }
        }
    }
    
    func convertDate() {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 :greeting = "Good Morning"
        case 12 : greeting = "How do you do? It's already noon!"
        case 13..<17 : greeting = "Good afternoon"
        case 17..<22 : greeting = "You are almost done for the day. Sit back and relax!"
        default:
            greeting = "Hello"
        }
    }
}


