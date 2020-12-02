//
//  RegisterUser.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI

struct RegisterUser: View {
    
    @StateObject var registerData = RegisterViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("User Info")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color"))
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            ZStack{
                if registerData.image_Data.count == 0 {
                    Image(systemName: "person")
                        .font(.system(size: 85))
                        .foregroundColor(.black)
                        .frame(width: 115, height: 115)
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
                Button(action: registerData.register, label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("lightblue"))
                        .clipShape(Capsule())
                })
                .disabled(registerData.image_Data.count == 0 || registerData.name == "" || registerData.interest == ""  || registerData.bio == "" ? true : false)
                .opacity(registerData.image_Data.count == 0 || registerData.name == "" || registerData.interest == ""  || registerData.bio == "" ?  0.5 : 1)
            }
  
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }
        .background(Color("Color").ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $registerData.picker, content: {
            ImagePicker(picker: $registerData.picker, img_Data: $registerData.image_Data)
        })
    }
}


