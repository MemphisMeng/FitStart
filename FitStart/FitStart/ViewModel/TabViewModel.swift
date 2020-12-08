//
//  TabViewModel.swift
//  FitStart
//
//  Created by vivian on 11/14/20.
//

import SwiftUI

class TabViewModel : ObservableObject {
    @Published var selectedItem : ExGoal!
    @Published var isDetail = false
}
