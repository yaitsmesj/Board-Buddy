//
//  ClipboardMonitor.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

class ClipboardMonitor {
    private var latestClipboardContent: String = ""
    private var lastKnownChangeCount = ClipboardManager.shared.changeCount
    private var clipboardCheckTimer: Task<Void, Never>?
    
    init() {
        clipboardCheckTimer = Task {
            while Task.isCancelled == false {
                checkForClipboardChanges()
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000) // Sleep for 1 second
                } catch {
                    print("Error in Task.sleep")
                }
            }
        }
    }
    
    func checkForClipboardChanges() {
        if(self.lastKnownChangeCount != ClipboardManager.shared.changeCount){
            print("Running")
            let newClipboardContent = ClipboardManager.shared.getString()
            if let newContent = newClipboardContent, newContent != self.latestClipboardContent {
                self.latestClipboardContent = newContent
                Task { @MainActor in
                    updateDataBasedOnNewContent()
                }
            }
            self.lastKnownChangeCount = ClipboardManager.shared.changeCount
            print("Count Updated: \(self.lastKnownChangeCount)")
        }
    }
    
    @MainActor func updateDataBasedOnNewContent() {
        let hashID = DataUtility.shared.hashData(input: latestClipboardContent)
        let item = DataUtility.shared.fetchData(dataId: hashID)
        if let item = item {
            item.copyTime = .now
        } else {
            let data = TextData(id: hashID, text: latestClipboardContent)
            print(data.id)
            Container.shared.mainContext.insert(data)
        }
    }
    
    deinit {
        print("Deinit ClipboardMonitor and cancel timer")
        clipboardCheckTimer?.cancel()
    }
}
