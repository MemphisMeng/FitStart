//
//  Meal.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI
import UIKit
import Foundation
struct Meal: View {
    @State var results : String = ""
    var body : some View {
        VStack {
            HStack (alignment: .top) {
                HStack (alignment: .top, spacing: 15) {
                    Text("Today")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Warren")
                }
                
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 18)
            .padding()
            .padding(.bottom, 80)
            .background(Color("Color"))
            
            Spacer()
           
            ZStack {
                ScrollView() {
                    Text(results)
                }
                
            }
            .onAppear(perform: loadData)

        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
    func loadData() {
        guard let url = URL(string: "https://www.bu.edu/dining/api/locations/warren/menu/2020-11-23/") else {
            print("Invalid URL")
            return
        }
        let request =  URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            results = String(data: data!, encoding: .utf8)!
        }
        .resume()
    }
}

//struct Meal_Previews: PreviewProvider {
//    static var previews: some View {
//        Meal()
//    }
//}




//struct foodView : View {
//    var body : some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text(data.name)
//                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//
//            HStack(spacing: 15) {
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("points")
//                        .font(.title)
//                    Text("10")
//                        .font(.title)
//
//                }
//                VStack(alignment: .leading, spacing: 12) {
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("is_glutenfree")
//                        Text(getValue(data: data.is_glutenfree))
//                            .foregroundColor(.red)
//                    }
//                    Divider()
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("is_vegan")
//                        Text(getValue(data: data.is_vegan))
//                            .foregroundColor(.yellow)
//                    }
//                    Divider()
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("protein")
//                        Text(getValue(data: data.protein))
//                            .foregroundColor(.blue)
//                    }
//                    Divider()
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("calories")
//                        Text(getValue(data: data.calories))
//                            .foregroundColor(.red)
//                    }
//                }
//            }
//        }
//        .padding()
//        .frame(width: UIScreen.main.bounds.width - 30)
//        .background(Color.white)
//        .cornerRadius(20)
//    }
//}

struct Response: Codable {
    var results: [Food]
}

struct Food : Codable, Hashable {
    var name: String
    var is_vegan: Bool
    var is_glutenfree: Bool
    var calories: Int
    var protein: Int
}

//class getData : ObservableObject {
//    @Published var dishes = [Food]()
//    init() {
//        let url = "https://www.bu.edu/dining/api/locations/warren/menu/2020-11-23/"
//
//    }
//    func updateData() {
//        let url = "https://www.bu.edu/dining/api/locations/warren/menu/2020-11-23/"
//        let session =  URLSession(configuration: .default)
//
//        session.dataTask(with: URL(string: url)!) { (data, _, error) in
//            if error != nil {
//                print((error?.localizedDescription))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Food.self, from: data!)
//                DispatchQueue.main.async {
//
//                }
//            } catch let error {
//
//            }
//
//        }
//        .resume()
//    }
//}


