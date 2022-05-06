//
//  Task.swift
//  NightWatch
//
//  Created by Evan Masterson on 04/05/2022.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isComplete: Bool = false
    var lastCompleted: Date?
}
