//
//  TextData.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import Foundation
import SwiftData

@Model
class TextData: Identifiable, NSCopying {
    
    let id : Data
    var title: String
    var text: String
    var isPinned: Bool
    var copyTime: Date
    
    init(id: Data? = nil, title: String = "", text: String = "", isPinned: Bool = false, copyTime: Date = .now) {
        self.title = title
        self.text = text
        self.isPinned = isPinned
        self.copyTime = copyTime
        self.id = id ?? DataUtility.shared.hashData(input: text)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = TextData(title: title, text: text, isPinned: isPinned, copyTime: copyTime)
        return copy
    }
    
}
