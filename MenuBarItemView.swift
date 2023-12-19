//
//  MenuBarItemView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 20/12/23.
//

import SwiftUI

struct MenuBarItemView: View {
    var text: String
    @State private var isHovered = false
    var body: some View {
        Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
            .lineLimit(1)
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isHovered ? Color.accentColor : Color.clear)
            .onHover(perform: { hovering in
                isHovered = hovering
            })
            .onTapGesture {
                ClipboardMonitor.shared.copyTextToClipboard(text: text)
            }
    }
}

#Preview {
    MenuBarItemView(text: "Preview Text")
}
