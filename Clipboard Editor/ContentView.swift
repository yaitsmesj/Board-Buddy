//
//  ContentView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var clipBoardMonitor = ClipboardMonitor()
    @State private var searchText = ""
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack {
            List {
                dataSection(header: "Pinned", systemImage: "pin.fill", isPinned: true)
            }
            
            List {
                dataSection(header: "Recents", systemImage: "clock.fill", isPinned: false)
            }
        }
        .navigationTitle("All Things Clipboard")
        .toolbar {
            Toolbar()
        }
        .searchable(text: $searchText)
        .onAppear(perform: initializeClipboard)
    }
    
    private func dataSection(header: String, systemImage: String, isPinned: Bool) -> some View {
        Section(header: Label(header, systemImage: systemImage)) {
            DataFilterView(sort: SortDescriptor(\TextData.copyTime, order: .reverse),
                           isPinned: isPinned, searchString: searchText)
        }
    }
    
    func initializeClipboard() {
        // TODO: Initialize things
    }
    
    
}

#Preview {
    ContentView()
}
