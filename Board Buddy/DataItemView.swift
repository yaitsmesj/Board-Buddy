//
//  DataItemView.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//
import SwiftUI
import SwiftData

struct DataItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openWindow) private var openWindow
    
    @Bindable var data: TextData
    @Binding var isEditing: Bool
    
    @State private var isSelected = false
    @State private var isHovering = false
    
    var body: some View {
        HStack {
            titleAndTextView
            Spacer()
            actionButtons
        }
        .padding(10)
        .background(isSelected ? Color.blue : Color(NSColor.windowBackgroundColor))
        .shadow(radius: 5)
        .opacity(isHovering ? 0.8 : 1.0)
        .onHover(perform: setHoverState)
        .onTapGesture(perform: handleTap)
        .onChange(of: isEditing, resetSelection)
    }
    
    private var titleAndTextView: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Title", text: $data.title)
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
                .onChange(of: data.title, enforceTitleLimit)
            Text(data.text)
                .font(.body)
                .lineLimit(3)
                .foregroundColor(.primary)
                .lineSpacing(4)
                .padding(.vertical, 5)
                .truncationMode(.tail)
            Spacer()
        }
    }
    
    private var actionButtons: some View {
        VStack(spacing: 10) {
            Button(action: { openWindow(value: data.id) }) {
                Image(systemName: "arrow.up.forward.bottomleading.rectangle")
            }
            Button(action: { data.isPinned.toggle() }) {
                Image(systemName: data.isPinned ? "pin.fill" : "pin")
            }
            Button(action: { modelContext.delete(data) }) {
                Image(systemName: "trash")
            }
        }
    }
    
    private func enforceTitleLimit(_ : String ,_ title: String) {
        if title.count > 50 {
            data.title = String(title.prefix(50))
        }
    }
    
    private func setHoverState(_ isHovering: Bool) {
        self.isHovering = isHovering
    }
    
    private func handleTap() {
        if isEditing {
            isSelected.toggle()
        } else {
            ClipboardMonitor.shared.copyTextToClipboard(text: data.text)
        }
    }
    
    private func resetSelection(_ : Bool, _ isEditing: Bool) {
        if !isEditing {
            isSelected = false
        }
    }
}

#Preview {
    DataItemView(data: TextData(title: "Title Item" ,text: "Item"), isEditing: .constant(true))
}

