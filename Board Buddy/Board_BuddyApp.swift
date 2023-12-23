//
//  Board_BuddyApp.swift
//  Board Buddy
//
//  Created by Suraj Jain on 16/12/23.
//

import SwiftUI
import SwiftData

@main
struct Board_BuddyApp: App {
    var body: some Scene {
        Window("Main", id: "Main") {
            ContentView()
        }.commands {
            Menus()
        }.modelContainer(Container.shared)
        
        // Editor Window
        WindowGroup("Editor", for: TextData.ID.self) { $hashId in
            EditorView(hashId: hashId ?? DataUtility.shared.defaultHash)
        }.modelContainer(Container.shared)
            .commandsRemoved()
            .defaultSize(width: 400, height: 300)
        
        // Menu Bar
        MenuBarExtra("Copy Paste", systemImage: "pencil.and.list.clipboard") {
            MenuBarView().modelContainer(Container.shared)
        }.menuBarExtraStyle(.window)
            .defaultPosition(.trailing)
           // .modelContainer(ContainerInstance.shared)     // Error: Model Context is not being attached to MenuBarExtra
    }
}
