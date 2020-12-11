//
//  Station View.swift
//  FitStart
//
//  Created by Minglan  on 11/30/20.
//

import SwiftUI

struct Station_View: View {
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
                                print("Button action")
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
                        }
                        if (i.is_vegan) {
                            Button(action: {
                                print("Button action")
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
                        }
                            
                       
                    }
                    .padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    
                    
                    
                }
            }
        } )
    }
}

