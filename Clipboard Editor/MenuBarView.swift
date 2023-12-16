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
    }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)]) var pinnedItems: [TextData]
    
    @Query(filter: #Predicate<TextData> { item in
        !item.isPinned
    }, sort: [SortDescriptor(\TextData.copyTime, order: .reverse)]) var recentItems: [TextData]
    
    var body: some View {
            HStack {
                VStack {
                    if pinnedItems.isEmpty {
                        ContentUnavailableView {
                            Label("No pinned items", systemImage: "pin.fill")
                                .font(.title2)
                        }
                        
                    } else {
                        List(pinnedItems, id: \.self) { item in
                            Text(item.text.trimmingCharacters(in: .whitespacesAndNewlines))
                                .lineLimit(1)
                        }
                        .frame(width: 250)
                        .fixedSize(horizontal: true, vertical: true)
                        Spacer()
                    }
                }
                VStack{
                    if recentItems.isEmpty {
                        ContentUnavailableView {
                            Label("No recent items", systemImage: "clock.fill")
                                .font(.title2)
                        }
                        
                    } else {
                        List(recentItems, id: \.self) { item in
                            Text(item.text.trimmingCharacters(in: .whitespacesAndNewlines))
                                .lineLimit(1)
                        }
                        .frame(width: 250)
                        .fixedSize(horizontal: true, vertical: true)
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
