//
//  Station View.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

struct Station_View: View {
    @State private var showingAlert = false
    var ref: Firestore!
    
    var station_ : station
    var food : [food] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            VStack {
                ForEach(station_.menu_items, id: \.self) { i in
                    Divider()
                    .frame(width: 400, height: 1)
                    .background(Color("Black"))
                    .padding(.vertical,0)
                    HStack {
                        VStack (alignment: .leading) {
                            Text(i.name + ", " + i.calories + "cal, protein: " + i.protein)
                            .font(.headline)
                            .foregroundColor(Color("Black"))
                                
                        }.padding(.leading, 8)
                        Spacer()
                        if (Int(i.protein)! > 10) {
                            Button(action: {
//                                print("Button action")
                                
                                let docRef = ref?.collection("users").document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")
                                docRef?.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                                        print("Document data: \(dataDescription)")
                                    } else {
                                        print("Document does not exist")
                                    }
                                }
                                self.showingAlert = true
                            }) {
                                HStack {
                                    Image(systemName: "p.circle")
                                    Text("+50xp")
                                }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            }
                            .alert(isPresented: $showingAlert) {
                            () -> Alert in
                            Alert(title: Text("Congratulations!"), message: Text("You had a protein meal, XP+50!"), dismissButton: .default(Text("OK")))
                                }
                        }
                        if (i.is_vegan) {
                            Button(action: {
//                                print("Button action")
                                let docRef = ref?.collection("users").document("7lqIqxc7SGPrbRhhQWZ0rdNuKnb2")
                                docRef?.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                                        print("Document data: \(dataDescription)")
                                    } else {
                                        print("Document does not exist")
                                    }
                                }
                                self.showingAlert = true
                            }) {
                                HStack {
                                    Image(systemName: "leaf")
                                    Text("+50xp")
                                }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            }
                            .alert(isPresented: $showingAlert) {
                                () -> Alert in
                                Alert(title: Text("Congratulations!"), message: Text("You had a vegan meal, XP+50!"), dismissButton: .default(Text("OK")))
                                    }
                        }
                            
                       
                    }
                    .padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    
                    
                    
                }
            }
        } )
    }
}

