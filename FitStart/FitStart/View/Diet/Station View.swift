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
                    HStack {
                        VStack (alignment: .leading) {
                            Text(i.name + "," + i.calories + "cal, P:" + i.protein)
                            .font(.headline)
                            .foregroundColor(Color("Black"))
                                
                        }.padding(.leading, 8)
                        Spacer()
                        if (Int(i.protein)! > 10) {
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(width: 30, height: 30)
                                .background(Color("5324FF"))
                                .clipShape(Capsule())
                                .padding(.trailing)
                        }
                        if (i.is_vegan) {
                            Image(systemName: "leaf")
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(width: 30, height: 30)
                                .background(Color("5324FF"))
                                .clipShape(Capsule())
                                .padding(.trailing)
                        }
                            
                       
                    }
                    .padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    
                    
                    Divider()
                    .frame(width: 400, height: 1)
                    .background(Color("Black"))
                    .padding(.vertical,0)
                }
            }
        } )
    }
}

