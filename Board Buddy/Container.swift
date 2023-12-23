//
//  Container.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftData

class Container {
    static let shared: ModelContainer = {
        let schema = Schema([TextData.self])
        do {
            let container = try ModelContainer(for: schema, configurations: [])
            return container
        } catch {
            fatalError("Schema Creation Failed")
        }
    }()
}
