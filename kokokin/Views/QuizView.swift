import SwiftUI

struct QuizView: View {
    let questions: [Question]
    let title: String
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var userAnswers: [String] = []
    @State private var isQuizComplete = false

    // Computed property to calculate the number of correct answers
    private var correctCount: Int {
        questions.indices.reduce(0) { count, index in
            getCorrectAnswerCount(for: index) >= questions[index].requiredCount ? count + 1 : count
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            if !isQuizComplete {
                // Quiz Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.gray)
                    ProgressView(value: Double(currentQuestionIndex + 1) / Double(questions.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                }
                .padding(.horizontal)

                // Question and Answer
                VStack(alignment: .leading, spacing: 12) {
                    Text("Q\(currentQuestionIndex + 1): \(questions[currentQuestionIndex].question)")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    AutoSizingTextField(text: $userAnswer)
                        .frame(maxHeight: 120)
                        .padding()
                }

                // Navigation Buttons
                HStack {
                    Button(action: {
                        saveCurrentAnswer()
                        prevQuestion()
                    }) {
                        Text("戻る")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(currentQuestionIndex > 0 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(currentQuestionIndex == 0)

                    Button(action: {
                        saveCurrentAnswer()
                        nextQuestion()
                    }) {
                        Text("次へ")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            } else {
                // Quiz Completion View
                Text("結果: \(questions.count)問中\(correctCount)問正解")
                    .font(.title)
                    .padding(.top)
                
                List(Array(questions.indices), id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Q\(index + 1): \(questions[index].question)")
                            .font(.headline)
                        Text("正解数: \(getCorrectAnswerCount(for: index))/\(questions[index].requiredCount)")
                            .foregroundColor(.blue)
                        Text("あなたの回答: \n\(userAnswers[index])")
                            .foregroundColor(getCorrectAnswerCount(for: index) >= questions[index].requiredCount ? .green : getCorrectAnswerCount(for: index) >= 1 ? .yellow : .red)
                            .font(.callout)
                        Text("解答例: \n\(formatAnswers(questions[index].answer))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: restartQuiz) {
                    Text("初めからやり直す")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .onAppear {
            if userAnswers.isEmpty {
                userAnswers = Array(repeating: "", count: questions.count)
            }
            userAnswer = userAnswers[currentQuestionIndex]
        }
    }

    // Function to calculate how many answers the user got correct
    private func getCorrectAnswerCount(for index: Int) -> Int {
        let question = questions[index]
        let userWords = userAnswers[index]
            .lowercased()
            .split { $0 == "、" || $0 == "," || $0 == "\n" }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        var correctCount = 0
        for group in question.answer {
            if group.contains(where: { keyword in userWords.contains(keyword.lowercased()) }) {
                correctCount += 1
            }
        }
        return correctCount
    }

    private func formatAnswers(_ answers: [[String]]) -> String {
        answers.map { $0.joined(separator: "、") }.joined(separator: "\n")
    }

    private func saveCurrentAnswer() {
        userAnswers[currentQuestionIndex] = userAnswer
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            userAnswer = userAnswers[currentQuestionIndex]
        } else {
            isQuizComplete = true
        }
    }

    private func prevQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            userAnswer = userAnswers[currentQuestionIndex]
        }
    }

    private func restartQuiz() {
        currentQuestionIndex = 0
        userAnswer = ""
        userAnswers = Array(repeating: "", count: questions.count)
        isQuizComplete = false
    }
}



#Preview {
    ContentView()
}
