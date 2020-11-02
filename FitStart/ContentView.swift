//
//  ContentView.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/1/20.
//
import SwiftUI

struct Task: Identifiable {
    var id: Int
    let message, imageName: String
}

struct ContentView: View {
    let tasks: [Task] = [
        .init(id: 0, message: "Exercise for 20 minutes, following the cardio and arm animations", imageName: "Running"),
        .init(id: 1, message: "Drink 3 cups of water", imageName: "Drink_Water"),
        .init(id: 2, message: "Go to bed before 10pm", imageName: "Exercise")
    ]
    
    var body: some View {
        NavigationView {
            List {
                QuoteView()
                Text("Goals").font(.largeTitle)
                ForEach(tasks) { task in
                    TaskRow(task: task)
                }
                //
            }
            
        }
    }
}

struct TaskRow: View {
    let task: Task
    var body: some View {
        HStack {
            Image(task.imageName)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .frame(width: 45, height: 40)
            VStack (alignment: .leading) {
                Text(task.message).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct QuoteView: View {
    var body: some View {
        ZStack {
            Text("“The secret of getting ahead is getting started.” – Mark Twain.").bold().position(CGPoint(x: 150, y: 0))
        }
        
    }
}

struct MenuBar: View {
    var body: some View {
        HStack {
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
