//
//  MenuBarView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct MenuBarView: View {
    @Environment(\.openWindow) private var openWindow
    
    @Query(filter: #Predicate<TextData> { item in
        item.isPinned
    }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var pinnedItems: [TextData]
    
    @Query(filter: #Predicate<TextData> { item in
        !item.isPinned
    }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var recentItems: [TextData]
    
    var body: some View {
        HStack {
            VStack {
                if pinnedItems.isEmpty {
                    ContentUnavailableView {
                        Label("No Pinned Items", systemImage: "pin.fill")
                            .font(.largeTitle)
                    }
                    .scaleEffect(0.5)
                    
                } else {
                    Section(
                        header: Label("Pinned", systemImage: "pin.fill")
                            .frame(maxWidth: .infinity, alignment: .leading)) {
                                List(pinnedItems, id: \.self) { item in
                                    MenuBarItemView(text: item.text)
                                        .clipShape(.rect(cornerRadius: CGFloat(integerLiteral: 10)))
                                }
                                .frame(width: 250)
                                .fixedSize(horizontal: true, vertical: true)
                                .padding(-10)
                            }
                    Spacer()
                }
            }
            VStack{
                if recentItems.isEmpty {
                    ContentUnavailableView {
                        Label("No Recent Items", systemImage: "clock.fill")
                            .font(.largeTitle)
                    }
                    .scaleEffect(0.5)
                    
                } else {
                    Section(
                        header: Label("Recents", systemImage: "clock.fill")
                            .frame(maxWidth: .infinity, alignment: .leading)) {
                                List(recentItems, id: \.self) { item in
                                    MenuBarItemView(text: item.text)
                                        .clipShape(.rect(cornerRadius: CGFloat(integerLiteral: 10)))
                                }
                                .frame(width: 250)
                                .fixedSize(horizontal: true, vertical: true)
                                .padding(-10)
                            }
                    Spacer()
                }
            }
        }
        .fixedSize(horizontal: true, vertical: true)
        .padding()
    }
}

#Preview {
    MenuBarView()
}
