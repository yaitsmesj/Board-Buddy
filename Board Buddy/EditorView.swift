//
//  EditorView.swift
//  Board Buddy
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
        HStack {
            TextEditor(text: $text)
                .font(.title3)
                .padding(5)
                .navigationTitle("Editor")
                .toolbar {
                    ToolbarItemGroup(placement: .automatic) {
                        Button("Save", action: {
                            print("Saved")
                        }).buttonStyle(PrimaryButtonStyle())
                            .help("Save Changes")
                        
                        Button("Close", action: {
                            print("Closed")
                        }).buttonStyle(SecondaryButtonStyle())
                            .help("Discard Changes")
                    }
                }
                .onAppear(perform: getTextData)
            // Add other modifiers for dark mode, animations, etc.
        }
        .frame(minWidth: 700, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity) // Make HStack fill the available space
    }
    
    // Functions for save and cancel actions
    func saveText() {
        print("Saved")
        // Implement actual save functionality
        // Show confirmation feedback
    }
    
    func cancelEditing() {
        print("Cancelled")
        // Implement cancel functionality
        // Optional: Clear text or confirm cancellation
    }
    
    // Custom button styles for a better UI
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
    struct SecondaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(5)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
    func getTextData() {
        print("Fetching data for hashId: \(hashId)")
        Task {
            let item = await DataUtility.shared.fetchData(dataId: hashId)
            guard let item = item else {
                print("No data found for hashId: \(hashId)")
                text = "Erro Occurred. Try Again"
                return
            }
            print("Data fetched: \(item)")
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
