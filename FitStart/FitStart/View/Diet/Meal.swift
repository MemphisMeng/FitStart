//
//  Meal.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI
import UIKit
import Foundation
struct Menu : Decodable {
    let api_url : String
    let date : String
    let meal_groups : Meal_Group
}

struct Meal_Group : Decodable {
    let Breakfast : Meal
    let Brunch : Meal
    let Lunch : Meal
    let Dinner : Meal
    struct Meal : Decodable {
        let name : String
        let stations : [station]
    }
}

struct station : Decodable, Hashable {
    let station_name : String
    let menu_items : [food]
}

struct food : Decodable, Hashable {
    let id : String
    let name : String
    let is_vegetarian : Bool
    let is_vegan : Bool
    let ingredients : String
    let is_glutenfree : Bool
    let calories : String
    let saturated_fat : String
    let protein : String
    let carbohydrates : String
}


struct Meal: View {
    @State private var day : String = "12"
    @State private var urlString : String = "12"
    @State var breakfast : [station] = []
    @State var brunch : [station] = []
    @State var lunch : [station] = []
    @State var dinner : [station] = []
    var body: some View {
        VStack {
            if breakfast.isEmpty && brunch.isEmpty && lunch.isEmpty && dinner.isEmpty {
                ProgressView()
            } else {
//                Text("breakfast")
//                    .font(.title3)
//                List(breakfast, id: \.self) { f in
//                    //display the food fetched
//                    Station_View(station_: f)
//                }
                //Meal Page
                VStack {
                    HStack {
                        Text("Breakfast \n 9:00-\n10:00AM")
                            .font(.body)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .background(Color("Color"))
                            .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                            .padding(.leading)
                        Text("Lunch \n 11:00-\n3:00 PM")
                            .font(.body)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .background(Color("Black"))
                            .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                            .padding(.leading)
                        Text("Dinner \n 5:00-\n9:00PM")
                            .font(.body)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .background(Color("Black"))
                            .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], size: 3))
                            .padding(.leading)
                    }
                    .padding(.top, 10)
                    Divider()
                    .frame(width: 400, height: 1)
                    .background(Color("Black"))
                    .padding(.vertical,0)
                    List(breakfast, id: \.self) { f in
                                        //display the food fetched
                        Station_View(station_: f)
                    }
                }
            }
        }.onAppear(perform: getDate)
    };func getDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        day = formatter.string(from: date)
        urlString = "https://www.bu.edu/dining/api/locations/warren/menu/" + day
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, error, _ in
           
//            print(String(data: data!, encoding: .utf8)!)
                do {
                    let menu = try JSONDecoder().decode(Menu.self, from: data!)
                    breakfast = menu.meal_groups.Breakfast.stations
                    brunch = menu.meal_groups.Brunch.stations
                    lunch = menu.meal_groups.Lunch.stations
                    dinner = menu.meal_groups.Dinner.stations
                } catch {
                    print("Fetch failed: \(error.localizedDescription ?? "Unknown error")")
                }
                   
        }.resume()
    }
    
}



struct Meal_Previews: PreviewProvider {
    static var previews: some View {
        Meal()
    }
}



