//
//  RegisterUser.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI
import Firebase
import Combine

struct RegisterUser: View {
    @StateObject var currentUser: userViewModel
    @State private var showingAlert = false
    
    init(currentUser: userViewModel) {
        self._currentUser = StateObject(wrappedValue: currentUser)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 15) {
                    Text("User Info")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                
                ZStack{
                    if currentUser.getPhoto().count == 0 {
                        Image(systemName: "person")
                            .font(.system(size: 80))
                            .foregroundColor(.black)
                            .frame(width: 115, height: 100)
                            .background(Color.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } else {
                        Image(uiImage: UIImage(data: currentUser.user.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 115, height: 115)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(.top)
                .onTapGesture(perform: {
                    currentUser.picker.toggle()
                })
                
                
                HStack (spacing: 15){
//                    TextFieldWithDefaultValue(model: currentUser, text: "Name")
                    TextField("Name", text: $currentUser.user.name)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                
                
                HStack (spacing: 15){
//                    TextFieldWithDefaultValue(model: currentUser, text: "Bio")
                    TextField("Bio", text: $currentUser.user.bio)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                
                HStack (spacing: 15){
                    TextField("Interest", text: $currentUser.user.interest)
//                        TextFieldWithDefaultValue(model: currentUser, text: "Interest")
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                .padding(.horizontal)
           
                if currentUser.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        currentUser.updatePersonalInfo()
                        self.showingAlert = true
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color("Color"))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .clipShape(Capsule())
                    })
                    .disabled(currentUser.getName() != "" || currentUser.getInterest() != ""  || currentUser.getBio() != "" ? false : true)
                    .opacity(currentUser.getName() != "" || currentUser.getInterest() != ""  || currentUser.getBio() != "" ?  1 : 0.5)
                    .alert(isPresented: $showingAlert) {
                        () -> Alert in
                        Alert(title: Text("Congratulations!"), message: Text("Saved successfully!"), dismissButton: .default(Text("OK")))
                            }
                }
            }
            .sheet(isPresented: $currentUser.picker, content: {
                ImagePicker(picker: $currentUser.picker, img_Data: $currentUser.user.image)
            })
        }
        
    }
}
