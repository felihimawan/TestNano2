//
//  TestNano2App.swift
//  TestNano2
//
//  Created by Felicia Himawan on 15/05/24.
//

import SwiftUI

@main
struct TestNano2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            HighScoreModel.self
        ])
    }
}
