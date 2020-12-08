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
//            Text(station_.station_name)
//                .font(.title3)
            VStack {
                ForEach(station_.menu_items, id: \.self) { i in
                    
                    HStack {
                        Text(i.name)
                        .font(.body)
                        .bold()
                        .foregroundColor(Color("Black"))
                        
                        Text("15xp")
                            .font(.body)
                            .foregroundColor(.white)
                            .background(Color("Color"))
                            .clipShape(Circle().size(.init(width: 25, height: 25)))
                            
                        Circle()
                            .foregroundColor(Color("Color"))
                            .clipShape(Circle().size(.init(width: 25, height: 25)))
                    }
                    
                    Text(i.calories + "cals")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                    Divider()
                    .frame(width: 400, height: 1)
                    .background(Color("Black"))
//                    .padding(.vertical,0)
                    
                }
            }
        } )
    }
}

