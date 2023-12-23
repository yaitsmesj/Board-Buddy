//
//  MenuBarView.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct MenuBarView: View {
    @Environment(\.openWindow) private var openWindow

    @Query(filter: #Predicate<TextData> { $0.isPinned }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var pinnedItems: [TextData]
    @Query(filter: #Predicate<TextData> { !$0.isPinned }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var recentItems: [TextData]

    private let itemCornerRadius: CGFloat = 10
    private let listWidth: CGFloat = 300

    var body: some View {
        HStack {
            itemsSection(items: pinnedItems, title: "Pinned", icon: "pin.fill")
            itemsSection(items: recentItems, title: "Recents", icon: "clock.fill")
        }
        .fixedSize(horizontal: true, vertical: true)
        .padding()
    }

    private func itemsSection(items: [TextData], title: String, icon: String) -> some View {
        VStack {
            if items.isEmpty {
                emptyContentView(title: title, icon: icon)
            } else {
                itemsListView(items: items, title: title, icon: icon)
            }
            Spacer()
        }
    }

    private func emptyContentView(title: String, icon: String) -> some View {
        ContentUnavailableView {
            Label("No \(title) items", systemImage: icon)
                .font(.largeTitle)
        }
        .scaleEffect(0.5)
    }

    private func itemsListView(items: [TextData], title: String, icon: String) -> some View {
        Section(header: Label(title, systemImage: icon).frame(maxWidth: .infinity, alignment: .leading)) {
            List(items, id: \.self) { item in
                MenuBarItemView(text: item.text)
                    .clipShape(RoundedRectangle(cornerRadius: itemCornerRadius))
            }
            .frame(width: listWidth)
            .fixedSize(horizontal: true, vertical: true)
            .padding(-10)
        }
    }
}

#Preview {
    MenuBarView()
}
