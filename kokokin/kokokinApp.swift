//
//  kokokinApp.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//

import SwiftUI

@main
struct kokokinApp: App {
    @StateObject private var quizData = QuizData() // Shared Data Model

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizData) // Provide QuizData to all views
        }
    }
}
