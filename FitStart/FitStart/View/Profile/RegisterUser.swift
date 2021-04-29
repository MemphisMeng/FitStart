//
//  RegisterUser.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase
struct RegisterUser: View {
    
    @StateObject var registerData = User()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("User Info")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                
                
                ZStack{
                    if registerData.image_Data.count == 0 {
                        Image(systemName: "person")
                            .font(.system(size: 80))
                            .foregroundColor(.black)
                            .frame(width: 115, height: 100)
                            .background(Color.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } else {
                        Image(uiImage: UIImage(data: registerData.image_Data)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 115, height: 115)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(.top)
                .onTapGesture(perform: {
                    registerData.picker.toggle()
                })
                
                
                
                HStack (spacing: 15){
                    TextField("Name", text: $registerData.name)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                
                
                HStack (spacing: 15){
                    TextField("Bio", text: $registerData.bio)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                
                HStack (spacing: 15){
                    TextField("Interest", text: $registerData.interest)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                .padding(.horizontal)
           
                if registerData.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        registerData.update()
                        self.showingAlert = true
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color("Color"))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .clipShape(Capsule())
                    })
                    .disabled(registerData.image_Data.count == 0 || registerData.name == "" || registerData.interest == ""  || registerData.bio == "" ? true : false)
                    .opacity(registerData.image_Data.count == 0 || registerData.name == "" || registerData.interest == ""  || registerData.bio == "" ?  0.5 : 1)
                    .alert(isPresented: $showingAlert) {
                        () -> Alert in
                        Alert(title: Text("Congratulations!"), message: Text("Saved successfully!"), dismissButton: .default(Text("OK")))
                            }
                }
                VStack{
                    Text("")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        
                    }) {
                        Text("Log out")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 10)
                }
            }
            .sheet(isPresented: $registerData.picker, content: {
                ImagePicker(picker: $registerData.picker, img_Data: $registerData.image_Data)
            })
            
            
        }
        
    }
}


