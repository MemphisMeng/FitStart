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
    //For updating data
    @Published var updateItem : Goal!
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
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            try! context.save()
            updateItem = nil
            isNewData.toggle()
        } else {
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
   
    func EditItem(item: Goal) {
        updateItem = item
        date = item.date!
        content  = item.content!
        isNewData.toggle()
        
    }
}
