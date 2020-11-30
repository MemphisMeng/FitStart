//
//  Meal.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI
import UIKit
import Foundation
struct menu : Decodable {
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

struct station : Decodable {
    let station_name : String
    let menu_items : [food]
    struct food : Decodable {
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
}





struct Meal: View {
    @State private var day : String = "12"
    @State private var urlString : String = "12"
    var body: some View {
        VStack {
            
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
                    let meal = try JSONDecoder().decode(menu.self, from: data!)
                    print(meal)
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



