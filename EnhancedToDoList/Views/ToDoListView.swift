//
//  ToDoListView.swift
//  EnhancedToDoList
//
//  Created by Tom Wu on 2024-01-18.
//

import SwiftUI

struct ToDoListView: View {
    // MARK: Stored properties
        
        // Our list of items to complete
        @State private var items: [TodoItem] = []
        
        // MARK: Computed properties
        var body: some View {
            NavigationStack {
                VStack {
                    
                    List(items) { currentItem in
                        Label {
                            Text(currentItem.details)
                        } icon: {
                            Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                        }
                    }
                }
                .navigationTitle("Tasks")
            }
            .onAppear {
                // Populate with example data
                if items.isEmpty {
                    items.append(contentsOf: exampleData)
                }
            }
        }
}

#Preview {
    LandingView()
}
