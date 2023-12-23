//
//  ContentView.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var clipboardMonitor = ClipboardMonitor.shared
    @State private var searchText = ""
    @State private var isEditing = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack {
            List{
                clipboardSection(title: "Pinned", systemImage: "pin.fill", isPinned: true)
            }
            List{
                clipboardSection(title: "Recents", systemImage: "clock.fill", isPinned: false)
            }
        }
        .navigationTitle("All Things Clipboard")
        .toolbar {
            Toolbar(isEditing: $isEditing)
        }
        .searchable(text: $searchText)
        .onAppear(perform: initializeClipboard)
    }
    
    private func clipboardSection(title: String, systemImage: String, isPinned: Bool) -> some View {
        Section(header: Label(title, systemImage: systemImage)) {
            DataFilterView(sort: SortDescriptor(\TextData.copyTime, order: .reverse),
                           isPinned: isPinned, searchString: searchText, isEditing: $isEditing)
        }
    }
    
    func initializeClipboard() {
        // TODO: Initialize things
        //        NSApp.appearance = NSAppearance(named: .darkAqua)
        
    }
    
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TextData.self, configurations: config)
    
    for i in 1..<10 {
        let data = TextData(title: "Title \(i)", text: "Text \(i)")
        if i.isMultiple(of: 2) {
            data.isPinned = true
        }
        container.mainContext.insert(data)
    }
    return ContentView().modelContainer(container)
    
}
