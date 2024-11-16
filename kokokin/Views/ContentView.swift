//
//  ContentView.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quizData = QuizData() // Load quiz data from JSON
    @State var selectectTab = 0
    
    var body: some View {
        TabView(selection: $selectectTab) {
            
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
            }.tabItem {
                Image(systemName: "plus")
                Text("問題")
            }.tag(0)
                
                Text("Hello").tabItem{ Image(systemName: "plus")
                    Text("勉強")
                }.tag(1)
                
                Text("Hello").tabItem{ Image(systemName: "pencil")
                    Text("記録")
                }.tag(2)
                
            }
        }
}

#Preview {
    ContentView()
}
