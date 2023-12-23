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

    private let paddingSize: CGFloat = 5

    var body: some View {
        Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
            .lineLimit(1)
            .padding(paddingSize)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundForHoverState)
            .onHover(perform: handleHover)
            .onTapGesture(perform: handleTap)
    }

    private var backgroundForHoverState: Color {
        isHovered ? Color.accentColor : Color.clear
    }

    private func handleHover(_ isHovering: Bool) {
        isHovered = isHovering
    }

    private func handleTap() {
        ClipboardMonitor.shared.copyTextToClipboard(text: text)
    }
}
#Preview {
    MenuBarItemView(text: "Preview Text")
}
