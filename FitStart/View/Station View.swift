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
            Text(station_.station_name)
                .font(.title3)
            VStack {
                ForEach(station_.menu_items, id: \.self) { i in
                    Text("Name: " + i.name)
                    Text("Calories" + i.calories)
                }
            }
        } )
    }
}

