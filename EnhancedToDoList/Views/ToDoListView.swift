//
//  ToDoListView.swift
//  EnhancedToDoList
//
//  Created by Tom Wu on 2024-01-18.
//

import SwiftData
import SwiftUI

struct ToDoListView: View {
    // MARK: Stored properties
    @Environment(\.modelContext) private var modelContext
    
    // The item currently being created
    @State private var newItemDetails = ""
    
    // Our list of items to complete
    @Query private var items: [TodoItem]
    
    @State var searchText = ""
    
    // Provide list of to-do items filtered based on the search text
    var filteredItems: [TodoItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.details.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter a to-do item", text: $newItemDetails)
                    
                    Button("Add") {
                        addItem()
                    }
                }
                .padding(20)
                
                if items.isEmpty {
                    ContentUnavailableView(label: {
                        Label(
                            "Nothing to do",
                            systemImage: "powersleep")
                            .foregroundColor(.green)
                    }, description: {
                        Text("To do items will appear once you add some")
                    })
                } else {
                    List {
                        ForEach(filteredItems) { currentItem in
                            HStack {
                                Label {
                                    Text(currentItem.details)
                                } icon: {
                                    Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                                        .onTapGesture {
                                            toggle(item: currentItem)
                                        }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            deleteItems(at: indexSet)
                        }
                        .searchable(text: $searchText)
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        modelContext.insert(newToDoItem)
        newItemDetails = ""
    }
    
    func toggle(item: TodoItem) {
        if item.isCompleted {
            item.completedOn = nil
            item.isCompleted = false
        } else {
            item.completedOn = Date()
            item.isCompleted = true
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(items[offset])
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

