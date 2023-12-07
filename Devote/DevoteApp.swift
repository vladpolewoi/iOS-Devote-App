//
//  DevoteApp.swift
//  Devote
//
//  Created by Quest76 on 05.12.2023.
//

import SwiftUI

@main
struct DevoteApp: App {
  let persistenceController = PersistenceController.shared
  @AppStorage("isDarkMode") var isDarkMode: Bool = false

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
  }
}
