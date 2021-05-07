//
//  MemphisProfileSummary.swift
//  FitStart
//
//  Created by Memphis Meng on 5/5/21.
//

import Foundation
import SwiftUI
import Firebase

struct ProfileSummary: View {
//    var profile: CustomProfile
    @StateObject var user = DBDownloaderViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
//                if self.user.currentPhoto != nil {
//                    Image(self.user.currentPhoto!)
//                } else {
//                    self.user.currentPhoto
//                        .font(.system(size: 80))
//                        .foregroundColor(Color("Color"))
//                        .frame(width: 115, height: 100)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                }
                self.user.currentPhoto
                    .font(.system(size: 80))
                    .foregroundColor(Color("Color"))
                    .frame(width: 115, height: 100)
                    .background(Color.white)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                        Text(self.user.currentName ?? "NaN")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color("Color"))
                    
                    HStack {
                        Text("Bio:")
                            .foregroundColor(Color("Color"))
                        Text(self.user.currentBio ?? "NaN")
                            .foregroundColor(Color("Color"))
                    }
                    HStack {
                        Text("Interests:")
                            .foregroundColor(Color("Color"))
                        Text(self.user.currentInterest ?? "NaN")
                            .foregroundColor(Color("Color"))
                    }
                    Divider()
                }
            }
            VStack(alignment: .center) {
                Text("My groups")
                    .font(.headline)
                    .foregroundColor(Color("Color"))
                
                
                ScrollView(.horizontal) {
                    HStack {
                        VStack {
                            Image("photography")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .padding(.top)
                                .padding(.leading, 15)
                            Text("Photography")
                                .font(.system(size: 10))
                        }
                        
                        VStack {
                            Image("guitar")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .padding(.top)
                                .padding(.leading, 15)
                            Text("Guitar")
                                .font(.system(size: 10))
                        }
                        
                        VStack {
                            Image("reading")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .padding(.top)
                                .padding(.leading, 15)
                            Text("Reading")
                                .font(.system(size: 10))
                        }
                    }
                    .padding(.bottom)
                }
            }
            Spacer()
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
    }
}

struct CustomProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}
