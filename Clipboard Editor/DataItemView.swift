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
    
    @State private var isHovered = false
    @State private var isPressed = false
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                TextField("Title", text: $data.title)
                //TODO: Add Text Limit
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                    .onChange(of: data.title) { oldValue, newValue in
                        if newValue.count > 50 {
                            data.title = String(newValue.prefix(50))
                        }
                    }
                Text(data.text)
                    .font(.body) 
                    .lineLimit(3)
                    .foregroundColor(.primary)
                    .lineSpacing(4)
                    .padding(.vertical, 5)
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
        //        .scaleEffect(isPressed ? 0.99 : 1.0)
        .shadow(radius: 5)
        .opacity(isHovered ? 0.8 : 1.0)
//        .animation(.spring(response: 0.1, dampingFraction: 0.2), value: isPressed)
        .onHover { hovering in
            isHovered = hovering
        }
        .onTapGesture {
//            isPressed = true
            ClipboardMonitor.shared.copyTextToClipboard(text: data.text)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
//                isPressed = false
//            }
        }
    }
}


#Preview {
    DataItemView(data: TextData(title: "Title Item" ,text: "Item"))
}

