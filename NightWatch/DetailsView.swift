//
//  DetailsView.swift
//  NightWatch
//
//  Created by Evan Masterson on 25/03/2022.
//

import SwiftUI

struct DetailsView: View {
    @Binding var task: Task
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "map")
                Text("Placeholder for motel floor plan")
            }
            Text(task.name)
            
            if verticalSizeClass == .regular {
                Divider()
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id vestibulum dolor. Integer aliquam nunc id arcu efficitur, vel consectetur orci eleifend. Quisque ut dignissim quam. Suspendisse commodo porta libero in consequat. Duis auctor a mi ut rhoncus. Nunc facilisis ornare orci posuere dapibus. Nam porttitor tempus ullamcorper.")
            }
            Button("Mark Complete") {
                task.isComplete = true
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailsView(task: Binding<Task>.constant(Task(name: "Test task")))
        }
    }
}
