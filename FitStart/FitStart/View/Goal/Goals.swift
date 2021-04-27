//
//  Goal.swift
//  FitStart
//
//  Created by Minglan  on 12/3/20.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore

struct Goals: View {
    let current_user_id = Auth.auth().currentUser?.uid
    @State private var showingAlert = false
    var ref = Firestore.firestore()
    
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
                    Image("goalui")
                    .resizable()
                    .frame(width: 200, height: 150, alignment: .center)
                    .padding(.top, 20)
                        
                    
                    HStack{
                        Text(greeting)
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .foregroundColor(Color("5324FF"))
                            .onAppear(perform: convertDate)
                            
                        Spacer()
                        Button(action: {homeData.isNewData.toggle()}, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(width: 30, height: 30)
                                .background(Color("5324FF"))
                                .clipShape(Capsule())
                                .padding(.trailing)
                            
                        })
//                        .padding(10)
                        .sheet(isPresented: $homeData.isNewData, content: {
                            NewDataView(homeData: homeData)
                        })
                    }
//                    .padding(.top, 40)
//                    .ignoresSafeArea(.all, edges: .all)
                        
        
                    ScrollView(.vertical, showsIndicators: true, content: {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(results){goal in
                                HStack {
                                        //Mark as Complete
                                        Button(action: {
                                            context.delete(goal)
                                            try! context.save()
                                            let docRef = ref.collection("users").document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")
                                            docRef.getDocument { (document, error) in
                                                if let document = document, document.exists {
                                                    let xp = document.data()!["xp"] as! Int
                                                    docRef.updateData(["xp": xp + 50])
                                                } else {
                                                    print("Document does not exist")
                                                }
                                            }
                                            self.showingAlert = true
                                        }, label: {
                                            
                                            HStack {
                                                LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    .clipShape(Capsule())
                                                    .frame(width: 40, height: 40)
                                                    .padding(.leading)
                                            }
                                            
                                            ZStack{
                                                //Image(systemName: "checkmark")
                                                Text("50      ")
                                                    .foregroundColor(.white)
                                                    .frame(width: 35, height: 35)
                                                    .clipShape(Capsule())
                                            }
                                            .offset(x:-37)
                                            
                                        })
                                        .alert(isPresented: $showingAlert) {
                                        () -> Alert in
                                        Alert(title: Text("Congratulations!"), message: Text("You completed a goal today, XP+50!"), dismissButton: .default(Text("OK")))
                                            }
                                        
                                    VStack(alignment: .leading, spacing: 5) {
                                        
                                        Text(goal.content ?? "")
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.white)
//                                            .padding(.vertical)
                                            

                                            Text(goal.date ?? Date(), style: .date)
                                                .fontWeight(.semibold)
                                                .padding(.horizontal)
                                                .foregroundColor(Color.white)
                                                
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical)
                                    .background(LinearGradient(gradient: .init(colors: [Color("5182FF"), Color("8F66FF")]), startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 5)))
//                                    .padding(.vertical)
                                    .padding(.horizontal)
//                                    .padding(.leading)
//                                    .foregroundColor(.black)
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
        .navigationBarHidden(false)
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


