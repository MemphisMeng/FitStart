//
//  HomeViewModel.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI
import CoreData


class HomeViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    
    //For NewData
    @Published var isNewData = false
    //@Published var updateItem : Goal!
    let calender = Calendar.current
    func checkDate() -> String {
        if calender.isDateInToday(date) {
            return "Today"
        } else if calender.isDateInTomorrow(date) {
            return "Next Day"
        } else {
            return "Other Day"
        }
    }
    
    func updateDate(value: String) {
        if value == "Today" {date = Date()}
        else if value == "Next Day" {
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        } else {
            
        }
    }
    
    func writeData(context : NSManagedObjectContext) {
        let newTask = Goal(context: context)
        newTask.date = date
        newTask.content = content
        newTask.xp = 10
        do {
            try context.save()
            isNewData.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
   
}
