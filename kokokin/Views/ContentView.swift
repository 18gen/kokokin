//
//  ContentView.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quizData = QuizData() // Load quiz data from JSON

    var body: some View {
        NavigationView {
            List(quizData.folders, id: \.folder) { folder in
                NavigationLink(destination: QuizView(questions: folder.questions)) {
                    HStack {
                        Text(folder.folder)
                            .font(.headline)
                        Spacer()
                        ProgressView(value: quizData.progress[folder.folder] ?? 0)
                            .frame(width: 50)
                    }
                }
            }
            .navigationTitle("Quiz Topics")
        }
    }
}

#Preview {
    ContentView()
}
