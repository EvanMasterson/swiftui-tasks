//
//  NightWatchTasks.swift
//  NightWatch
//
//  Created by Evan Masterson on 04/05/2022.
//

import Foundation

class NightWatchTasks: ObservableObject {
    @Published var nightlyTasks = [
        Task(name: "Check all windows"),
        Task(name: "Check all doors"),
        Task(name: "Check that the safe is locked"),
        Task(name: "Check the mailbox"),
        Task(name: "Inspect security cameras"),
        Task(name: "Clear ice from sidewalks"),
        Task(name: "Document \"strange and unusual\" occurrences")
    ]

    @Published var weeklyTasks = [
        Task(name: "Check inside all vacant rooms"),
        Task(name: "Walk the perimeter of the property")
    ]

    @Published var monthlyTasks = [
        Task(name: "Test security alarm"),
        Task(name: "Test motion detectors"),
        Task(name: "Test smoke alarms")
    ]
}
