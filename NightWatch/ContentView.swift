//
//  ContentView.swift
//  NightWatch
//
//  Created by Evan Masterson on 24/03/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var nightWatchTasks: NightWatchTasks
    @State private var focusModeOn = false
    @State private var resetAlertShowing = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: TaskSectionHeader(symbolSystemName: "moon.stars", headerText: "Nightly Tasks")) {
                    
                    let taskIndicies = nightWatchTasks.nightlyTasks.indices
                    let tasks = nightWatchTasks.nightlyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndicies))
                    
                    ForEach(taskIndexPairs, id:\.0.id) {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.nightlyTasks
                        let theTasksBinding = tasksBinding[taskIndex]
                        
                        if !focusModeOn || (focusModeOn && !task.isComplete) {
                            NavigationLink(destination: DetailsView(task: theTasksBinding)) {
                                TaskRow(task: task)
                            }
                        }
                    }.onDelete { indexSet in
                        nightWatchTasks.nightlyTasks.remove(atOffsets: indexSet)
                    }
                    .onMove { indices, newOffset in
                        nightWatchTasks.nightlyTasks.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                Section(header: TaskSectionHeader(symbolSystemName: "sunset", headerText: "Weekly Tasks")) {
                    
                    let taskIndicies = nightWatchTasks.weeklyTasks.indices
                    let tasks = nightWatchTasks.weeklyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndicies))
                    
                    ForEach(taskIndexPairs, id:\.0.id) {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.weeklyTasks
                        let theTasksBinding = tasksBinding[taskIndex]
                        
                        if !focusModeOn || (focusModeOn && !task.isComplete) {
                            NavigationLink(destination: DetailsView(task: theTasksBinding)) {
                                TaskRow(task: task)
                            }
                        }
                    }.onDelete { indexSet in
                        nightWatchTasks.weeklyTasks.remove(atOffsets: indexSet)
                    }
                    .onMove { indices, newOffset in
                        nightWatchTasks.weeklyTasks.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                Section(header: TaskSectionHeader(symbolSystemName: "calendar", headerText: "Monthly Tasks")) {
                    
                    let taskIndicies = nightWatchTasks.monthlyTasks.indices
                    let tasks = nightWatchTasks.monthlyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndicies))
                    
                    ForEach(taskIndexPairs, id:\.0.id) {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.monthlyTasks
                        let theTasksBinding = tasksBinding[taskIndex]
                        
                        if !focusModeOn || (focusModeOn && !task.isComplete) {
                            NavigationLink(destination: DetailsView(task: theTasksBinding)) {
                                TaskRow(task: task)
                            }
                        }
                    }.onDelete { indexSet in
                        nightWatchTasks.monthlyTasks.remove(atOffsets: indexSet)
                    }
                    .onMove { indices, newOffset in
                        nightWatchTasks.monthlyTasks.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        resetAlertShowing = true
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Toggle(isOn: $focusModeOn, label: {
                        Text("Focus Mode")
                    })
                }
            }
        }.alert(isPresented: $resetAlertShowing) {
            Alert(title: Text("Reset List"), message: Text("Are you sure?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Yes, reset it"), action: {
                let refreshedNightWatchTasks = NightWatchTasks()
                self.nightWatchTasks.nightlyTasks = refreshedNightWatchTasks.nightlyTasks
                self.nightWatchTasks.weeklyTasks = refreshedNightWatchTasks.weeklyTasks
                self.nightWatchTasks.monthlyTasks = refreshedNightWatchTasks.monthlyTasks
            }))
        }
    }
}

struct HeaderText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
            .fontWeight(.heavy)
            .foregroundColor(.cyan)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
    }
}

struct TaskSectionHeader: View {
    let symbolSystemName: String
    let headerText: String
    
    var body: some View {
        HStack {
            Text(Image(systemName: symbolSystemName))
                .foregroundColor(.cyan)
                .font(.title3)
                .fontWeight(.heavy)
            HeaderText(text: headerText)
        }
        .font(.title3)
    }
}

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        VStack {
            if task.isComplete {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text(task.name)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                HStack {
                    Image(systemName: "square")
                    Text(task.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let nightWatchTasks = NightWatchTasks()
        Group {
            ContentView(nightWatchTasks: nightWatchTasks)
            ContentView(nightWatchTasks: nightWatchTasks)
                .preferredColorScheme(.dark)
        }
    }
}
