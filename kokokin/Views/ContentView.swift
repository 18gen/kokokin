//
//  ContentView.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var quizData = QuizData()
    @State var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Flashcards Tab
            NavigationView {
                List(quizData.folders, id: \.folder) { folder in
                    NavigationLink(destination: FlashcardView(questions: folder.questions, title: folder.folder)) {
                        HStack {
                            Text(folder.folder)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("勉強")
            }
            .tabItem {
                Image(systemName: "lightbulb")
                Text("勉強")
            }
            .tag(0)

            // Quiz Tab
            NavigationView {
                List(quizData.folders, id: \.folder) { folder in
                    NavigationLink(destination: QuizView(questions: folder.questions, title: folder.folder)) {
                        HStack {
                            Text(folder.folder)
                                .font(.headline)
                            Spacer()
                            ProgressView(value: quizData.progress[folder.folder] ?? 0)
                                .frame(width: 50)
                        }
                    }
                }
                .navigationTitle("ココキン問題集")
            }
            .tabItem {
                Image(systemName: "book")
                Text("問題")
            }
            .tag(1)

            Text("記録")
                .tabItem {
                    Image(systemName: "pencil")
                    Text("記録")
                }
                .tag(2)
        }
    }
}


#Preview {
    ContentView()
}
