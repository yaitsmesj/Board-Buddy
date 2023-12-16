//
//  DataItemView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct DataItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openWindow) private var openWindow
    
    @Bindable var data: TextData
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                TextField("Title", text: $data.title)
                //TODO: Add Text Limit
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(data.text)
                    .font(.title3)
                    .lineLimit(3)
                    .foregroundColor(.primary)
                    .lineSpacing(3)
                    .padding(.top, 2)
                    .truncationMode(.tail)
                Spacer()
            }
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    openWindow(value: data.id)
                }) {
                    Image(systemName: "arrow.up.forward.bottomleading.rectangle")
                }
                
                Button(action: {
                    data.isPinned.toggle()
                }) {
                    Image(systemName: data.isPinned ? "pin.fill" : "pin")
                }
                
                Button(action: {
                    modelContext.delete(data)
                }) {
                    Image(systemName: "trash")
                }
            }
        }
        .padding(10)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

#Preview {
    ContentView()
}

