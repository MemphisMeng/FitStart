//
//  DateButton.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct DateButton: View {
    var title : String
    @ObservedObject var homeData : HomeViewModel
    
    var body: some View {
        Button(action: {homeData.updateDate(value: title)}, label: {
            Text(title)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(
                    homeData.checkDate() == title ?
                    LinearGradient(gradient: .init(colors: [Color("Color")]), startPoint: .leading, endPoint: .trailing)
                        
                        : LinearGradient(gradient: .init(colors: [Color.white]), startPoint:.leading, endPoint: .trailing)
                )
                .cornerRadius(6)
            
        })
    }
}

