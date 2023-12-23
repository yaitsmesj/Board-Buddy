//
//  ClipboardManager.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import Foundation
import AppKit

class ClipboardManager {
    static let shared = ClipboardManager()
    var changeCount: Int {
        self.pasteBoard.changeCount
    }
    
    var pasteBoard: NSPasteboard
    
    private init() {
        self.pasteBoard = NSPasteboard.general
    }
    
    func getString() -> String? {
        return pasteBoard.string(forType: .string)
    }
    
    
    func getCount() -> Int {
        return pasteBoard.changeCount
    }
    
    func setString(text: String) {
        pasteBoard.clearContents()                      // Need to clear pasteBoard before copied something there. It kinds of create an empty item                                                           on pasteBoard to put the item and it also increases the count.
//        ClipboardMonitor.shared.lastKnownChangeCount += 1         // Increase count so ClipboardMonitor.checkForClipboardChanges doesn't run.

        pasteBoard.setString(text, forType: .string)
    }
}
