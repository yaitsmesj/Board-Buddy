//
//  Toolbar.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI

struct Toolbar: ToolbarContent {
    @Environment(\.modelContext) var modelContext
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .automatic) {
            Button {
                
            } label: {
                Image(systemName: "sidebar.left")
            }
            .help("Toggle Sidebar")
            
            Button {
                
            } label: {
                Image(systemName: "sidebar.right")
            }
            .help("Toggle Sidebar")
        }
        ToolbarItemGroup(placement: .automatic) {
            Button {
            } label: {
                Image(systemName: "pencil")
            }
            .help("Toggle Sidebar")
            
            Button {
                
            } label: {
                Image(systemName: "xmark.circle")
            }
            .help("Toggle Sidebar")
        }
    }
}


