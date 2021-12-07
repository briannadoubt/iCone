//
//  iConeApp.swift
//  Shared
//
//  Created by Bri on 12/5/21.
//

import SwiftUI

@main
struct iConeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            SidebarCommands()
        }
        #if os(macOS)
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified(showsTitle: true))
        #endif
    }
}

struct ContentView: View {
    var body: some View {
        IconGeneratorView()
            .frame(
                minWidth: 480,
                idealWidth: 480,
                maxWidth: .infinity
            )
            .fixedSize(horizontal: false, vertical: true)
    }
}
