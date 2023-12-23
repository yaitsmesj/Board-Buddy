//
//  DataFilterView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct DataFilterView: View {
    @Query(sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var dataItems: [TextData]
    private var isPinned: Bool
    @Binding var isEditing: Bool
    
    var body: some View {
        if dataItems.isEmpty {
            ContentUnavailableView {
                if isPinned {
                    Label("No Pinned Items", systemImage: "pin.fill")
                        .font(.title2)
                } else {
                    Label("No Recent Items", systemImage: "clock.fill")
                        .font(.title2)
                }
            }
        } else {
            ForEach(dataItems, id: \.self) { data in
                DataItemView(data: data, isEditing: $isEditing)
                    .clipShape(.rect(cornerRadius: CGFloat(integerLiteral: 10)))
                    .listRowSeparator(.hidden)
            }
        }
    }
    
    init(sort: SortDescriptor<TextData>, isPinned: Bool, searchString: String, isEditing: Binding<Bool>) {
        _dataItems = Query(filter: #Predicate { data in
            if searchString.isEmpty {
                return data.isPinned == isPinned
            } else {
                return data.isPinned == isPinned && (data.title.localizedStandardContains(searchString) ||
                                                     data.text.localizedStandardContains(searchString))
            }
            
        }, sort: [sort], animation: .smooth)
        self.isPinned = isPinned
        self._isEditing = isEditing
    }
}

#Preview {
    @State var isEditing: Bool = false
    return DataFilterView(sort: SortDescriptor(\TextData.copyTime), isPinned: true, searchString: "", isEditing: $isEditing)
}
