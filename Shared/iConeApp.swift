//
//  iConeApp.swift
//  Shared
//
//  Created by Bri on 12/5/21.
//

import SwiftUI

@main
struct iConeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
