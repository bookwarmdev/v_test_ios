//
//  vpdApp.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import SwiftUI

@main
struct vpdApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RepositoryListView()
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext
                )
        }
    }
}
