//
//  FlashcardView.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//
import SwiftUI

//struct FlashcardView: View {
//    let questions: [Question]
//    let title: String
//    @State private var currentQuestionIndex = 0
//    @State private var isFlipped = false
//    @State private var rotationAngle = 0.0
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text(title)
//                .font(.headline)
//                .padding(.top)
//
//            Spacer()
//
//            ZStack {
//                FlashcardContent(
//                    text: isFlipped ? formatAnswer(questions[currentQuestionIndex].answers) : questions[currentQuestionIndex].question,
//                    isFlipped: isFlipped
//                )
//                .rotation3DEffect(
//                    .degrees(rotationAngle),
//                    axis: (x: 0, y: 1, z: 0)
//                )
//                .onTapGesture {
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        rotationAngle += 180
//                        isFlipped.toggle()
//                    }
//                }
//            }
//
//            Spacer()
//
//            HStack {
//                Button(action: prevQuestion) {
//                    Text("前へ")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(currentQuestionIndex > 0 ? Color.blue : Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .disabled(currentQuestionIndex == 0)
//
//                Button(action: nextQuestion) {
//                    Text("次へ")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(currentQuestionIndex < questions.count - 1 ? Color.green : Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .disabled(currentQuestionIndex >= questions.count - 1)
//            }
//            .padding(.horizontal)
//        }
//        .padding(.vertical)
//    }
//
//    private func nextQuestion() {
//        if currentQuestionIndex < questions.count - 1 {
//            currentQuestionIndex += 1
//            resetFlashcard()
//        }
//    }
//
//    private func prevQuestion() {
//        if currentQuestionIndex > 0 {
//            currentQuestionIndex -= 1
//            resetFlashcard()
//        }
//    }
//
//    private func resetFlashcard() {
//        withAnimation(.none) {
//            rotationAngle = 0
//            isFlipped = false
//        }
//    }
//
//    // Format the answers into a readable string
//    private func formatAnswer(_ answers: [[String]]) -> String {
//        answers.map { $0.joined(separator: ", ") }.joined(separator: "\n")
//    }
//}
//
//struct FlashcardContent: View {
//    let text: String
//    let isFlipped: Bool
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(isFlipped ? Color.blue : Color.green)
//                .frame(width: 300, height: 200)
//                .shadow(radius: 8)
//
//            Text(text)
//                .font(.title3)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//                .padding()
//        }
//    }
//}
