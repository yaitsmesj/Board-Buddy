//
//  DataFilterView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct DataFilterView: View {
    @Query(sort: [SortDescriptor(\TextData.copyTime, order: .reverse)]) var dataItems: [TextData]
    
    var body: some View {
        ForEach(dataItems, id: \.self) { data in
            DataItemView(data: data)
        }
    }
    
    init(sort: SortDescriptor<TextData>, isPinned: Bool, searchString: String) {
        _dataItems = Query(filter: #Predicate { data in
            if searchString.isEmpty {
                return data.isPinned == isPinned
            } else {
                return data.isPinned == isPinned && (data.title.localizedStandardContains(searchString) ||
                                                     data.text.localizedStandardContains(searchString))
            }
            
        }, sort: [sort])
    }
}

#Preview {
    DataFilterView(sort: SortDescriptor(\TextData.copyTime), isPinned: true, searchString: "")
}
