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
import Firebase

struct Station_View: View {
    let current_user_id = Auth.auth().currentUser?.uid
    @State private var showingAlert = false
    var ref = Firestore.firestore()
    
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
                                let docRef = ref.collection("Users").document(current_user_id ?? "")
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let xp = document.data()!["xp"] as! Int
                                        docRef.updateData(["xp": xp + 50])
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
                                let docRef = ref.collection("Users").document(current_user_id ?? "")
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let xp = document.data()!["xp"] as! Int
                                        docRef.updateData(["xp": xp + 50])
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

