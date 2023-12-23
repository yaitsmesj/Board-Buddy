//
//  Toolbar.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI

struct Toolbar: ToolbarContent {
    @Environment(\.modelContext) var modelContext
    @Binding var isEditing: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .automatic) {
            Button {
                isEditing.toggle()
            } label: {
                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")            }
            .help(isEditing ? "Done Editing" : "Edit")
        }
        ToolbarItemGroup(placement: .automatic) {
            Button {
            } label: {
                Image(systemName: "pencil")
            }
            .help("Toggle Sidebar")
        }
    }
    
    init(isEditing: Binding<Bool>) {
        self._isEditing = isEditing
    }
}


