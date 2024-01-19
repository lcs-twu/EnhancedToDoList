//
//  LandingView.swift
//  EnhancedToDoList
//
//  Created by Tom Wu on 2024-01-18.
//

import SwiftUI

struct LandingView: View {
    
    @State var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ToDoListView()
                .tabItem {
                    Text("Tasks")
                    Image(systemName: "checklist")
                }
                .tag(1)
            
            StatisticsView()
                .tabItem {
                    Text("Stats")
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                .tag(2)
        }
    }
    
    // Allow the selected tab to be passed in
    init(selectedTab: Int = 1) {
        _selectedTab = State(initialValue: selectedTab)
    }
}

#Preview {
    LandingView()
}
