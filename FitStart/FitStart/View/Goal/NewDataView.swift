//
//  NewDataView.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            HStack {
                Text("\(homeData.updateItem == nil ? "Add New" : "Update") Goal")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("5324FF"))
                
                Spacer(minLength: 0)
            }
            .padding()
            
            TextEditor(text: $homeData.content)
                .padding()
            
            Divider()
                .padding(.horizontal)
            HStack{
                Text("When")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("5324FF"))
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack (spacing: 10){
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Next Day", homeData: homeData)
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            Button(action: {homeData.writeData(context: context)}, label: {
                Label(
                    title: { Text(homeData.updateItem == nil ? "Add New" : "Update")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        Color("5182FF")
                    )
                    .cornerRadius(8)
                
            })
            .padding()
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.8 : 1)
            
        }
        .background(Color("C2C2C2").opacity(0.08).ignoresSafeArea(.all, edges: .bottom))
    }
}

