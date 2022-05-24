//
//  lazyfishApp.swift
//  lazyfish
//
//  Created by ozline on 2022/5/24.
//

import SwiftUI

@main
struct lazyfishApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
