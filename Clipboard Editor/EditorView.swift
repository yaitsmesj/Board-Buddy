//
//  EditorView.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

struct EditorView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var dataItem = TextData(text: "")
    
    var hashId: Data
    @State var title: String = ""
    @State var text: String = ""
    @State var isPined: Bool = false
    @State var copyTime: Date = .now
    
    init(hashId: Data) {
        self.hashId = hashId
    }
    
    var body: some View {
        Form {
            TextEditor(text: $text)
            Button("Save") {
                print("Saved")
            }
            Button("Cancel") {
                print("Cancelled")
            }
        }
        .onAppear(perform: getTextData)
        
    }
    
    func getTextData() {
        Task { @MainActor in
            let item = DataUtility.shared.fetchData(dataId: hashId)
            guard let item = item else {return}
            title = item.title
            text = item.text
            isPined = item.isPinned
            copyTime = item.copyTime
        }
    }
}

#Preview {
    EditorView(hashId: DataUtility.shared.defaultHash)
}
