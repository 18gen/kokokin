//
//  QuizData.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//

import Foundation

struct QuizFolder: Codable {
    let folder: String
    let questions: [Question]
}

struct Question: Codable {
    let question: String
    let requiredCount: Int
    let answer: [[String]]
}


class QuizData: ObservableObject {
    @Published var folders: [QuizFolder] = []
    @Published var progress: [String: Double] = [:]

    init() {
        loadJSON()
    }

    private func loadJSON() {
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            do {
                let folders = try decoder.decode([QuizFolder].self, from: data)
                self.folders = folders
                self.initializeProgress()
                print("Loaded folders: \(folders)") // Debugging
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Failed to locate questions.json")
        }
    }


    private func initializeProgress() {
        for folder in folders {
            if progress[folder.folder] == nil {
                progress[folder.folder] = 0
            }
        }
    }
}
