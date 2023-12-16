//
//  DataUtility.swift
//  Clipboard Editor
//
//  Created by Suraj Jain on 16/12/23.
//

import CryptoKit
import Foundation
import SwiftData

class DataUtility {
    
    static let shared = DataUtility()
    lazy var defaultHash: Data = self.hashData(input: "")
    
    private init() {}
    
    func hashData(input: String) -> Data {
        guard let data = input.data(using: .utf8) else {
            fatalError("Error while encoding data to .utf8")
        }
        
        let hashed = SHA256.hash(data: data)
        return Data(hashed)
    }
    
    @MainActor func fetchData(dataId: Data) -> TextData? {
        var descriptor = FetchDescriptor<TextData>(predicate: #Predicate {item in
            item.id == dataId})
        descriptor.fetchLimit = 1
        do {
            let items = try Container.shared.mainContext.fetch(descriptor)
            return items.first
        } catch{
            fatalError("Error in Fetching TextData")
        }
    }
}

