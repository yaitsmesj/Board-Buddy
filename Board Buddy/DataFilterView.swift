//
//  DataFilterView.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct DataFilterView: View {
    @Query(sort: [SortDescriptor(\TextData.copyTime, order: .reverse)], animation: .smooth) var dataItems: [TextData]
    private var isPinned: Bool
    @Binding var isEditing: Bool
    
    private let cornerRadius: CGFloat = 10
    
    var body: some View {
        Group {
            if dataItems.isEmpty {
                emptyContentView
            } else {
                dataListView
            }
        }
    }
    
    private var emptyContentView: some View {
        ContentUnavailableView {
            Label(isPinned ? "No Pinned Items" : "No Recent Items", systemImage: isPinned ? "pin.fill" : "clock.fill")
                .font(.title2)
        }
    }
    
    private var dataListView: some View {
        ForEach(dataItems, id: \.self) { data in
            DataItemView(data: data, isEditing: $isEditing)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .listRowSeparator(.hidden)
        }
    }
    
    init(sort: SortDescriptor<TextData>, isPinned: Bool, searchString: String, isEditing: Binding<Bool>) {
        self.isPinned = isPinned
        self._isEditing = isEditing
        self._dataItems = Query(filter: createFilterPredicate(isPinned: isPinned, searchString: searchString), sort: [sort], animation: .smooth)
    }
    
    private func createFilterPredicate(isPinned: Bool, searchString: String) -> Predicate<TextData> {
        #Predicate { data in
            if searchString.isEmpty {
                return data.isPinned == isPinned
            } else {
                return data.isPinned == isPinned && (data.title.localizedStandardContains(searchString) ||
                                                     data.text.localizedStandardContains(searchString))
            }
        }
    }
}
#Preview {
    @State var isEditing: Bool = false
    return DataFilterView(sort: SortDescriptor(\TextData.copyTime), isPinned: true, searchString: "", isEditing: $isEditing)
}
