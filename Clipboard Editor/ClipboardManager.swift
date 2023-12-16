//
//  ClipboardManager.swift
//  Clipboard Editor
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
}
