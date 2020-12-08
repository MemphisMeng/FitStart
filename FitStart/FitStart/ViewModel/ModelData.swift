//
//  ModelData.swift
//  FitStart
//
//  Created by Minglan Zheng on 11/8/20.
//

import SwiftUI

struct ExerciseModel: Identifiable {
    var id = UUID().uuidString
    var image : String
    var title: String
    var xp: Int
}

var animations = [
    ExerciseModel(image: "Strength_01", title: "Lifting", xp: 30),
    ExerciseModel(image: "Strength_02", title: "Core", xp: 50),
    ExerciseModel(image: "Strength_03", title: "Weights", xp: 90),
    ExerciseModel(image: "WeightLoss_01", title: "Weights Lifting", xp: 30),
    ExerciseModel(image: "WeightLoss_04", title: "Core", xp: 100),
    ExerciseModel(image: "WeightLoss_03", title: "Running", xp: 30),
]

//For the type
var scroll_Tabs = ["Strength", "WeightLoss"]

