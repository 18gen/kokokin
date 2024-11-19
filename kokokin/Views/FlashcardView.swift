//
//  FlashcardView.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//
import SwiftUI

struct FlashcardView: View {
    let questions: [Question]
    let title: String
    @State private var currentQuestionIndex = 0
    @State private var isFlipped = false
    @State private var dragOffset: CGSize = .zero
    @State private var rotationAngle = 0.0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                // Title
                Text(title)
                    .font(.headline)
                    .padding(.top)

                // Page Tracker
                Text("\(currentQuestionIndex + 1)/\(questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Flashcard
                ZStack {
                    FlashcardContent(
                        text: isFlipped ? formatAnswers(questions[currentQuestionIndex].answer) : questions[currentQuestionIndex].question,
                        isFlipped: isFlipped,
                        size: CGSize(
                            width: geometry.size.width * 0.85,
                            height: geometry.size.height * 0.65
                        )
                    )
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                dragOffset = gesture.translation
                            }
                            .onEnded { gesture in
                                if abs(gesture.translation.width) > 100 {
                                    // Flip card
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        rotationAngle += 180
                                        isFlipped.toggle()
                                    }
                                }
                                dragOffset = .zero
                            }
                    )
                    .onTapGesture {
                        // Tap to flip
                        withAnimation(.easeInOut(duration: 0.5)) {
                            rotationAngle += 180
                            isFlipped.toggle()
                        }
                    }
                }

                Spacer()

                // Navigation Buttons
                HStack {
                    Button(action: prevQuestion) {
                        Text("前へ")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(currentQuestionIndex > 0 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(currentQuestionIndex == 0)

                    Button(action: nextQuestion) {
                        Text("次へ")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(currentQuestionIndex < questions.count - 1 ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(currentQuestionIndex >= questions.count - 1)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            resetFlashcard()
        }
    }

    private func formatAnswers(_ answers: [[String]]) -> String {
        answers.map { $0.joined(separator: "、") }.joined(separator: "\n")
    }

    private func prevQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            resetFlashcard()
        }
    }

    private func resetFlashcard() {
        withAnimation(.none) {
            rotationAngle = 0
            isFlipped = false
        }
    }
}

struct FlashcardContent: View {
    let text: String
    let isFlipped: Bool
    let size: CGSize

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(isFlipped ? Color.blue : Color.green)
                .frame(width: size.width, height: size.height)
                .shadow(radius: 8)

            GeometryReader { geometry in
                Text(text)
                    .font(.system(size: 25)) // Base font size
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
