import SwiftUI

struct QuizView: View {
    let questions: [Question]
    let title: String
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var userAnswers: [String] = [] // Store all user answers
    @State private var score = 0
    @State private var isQuizComplete = false

    var body: some View {
        VStack {
            if !isQuizComplete {
                // Quiz in Progress
                HStack {
                    Text(title)
                        .font(.headline)
                    Text("問題 \(currentQuestionIndex + 1) の \(questions.count)")
                        .font(.footnote)
                }
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .padding()
                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack{
                    Button("Next") {
                        userAnswers.append(userAnswer)
                        userAnswer = ""
                        nextQuestion()
                    }
                    Button("Next") {
                        userAnswers.append(userAnswer)
                        userAnswer = ""
                        nextQuestion()
                    }
                }
                .padding()
            } else {
                // Review Screen
                Text("結果")
                    .font(.largeTitle)
                List(0..<questions.count, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Q\(index + 1): \(questions[index].question)")
                            .font(.headline)
                        Text(userAnswers[index])
                            .foregroundColor(userAnswers[index].lowercased() == questions[index].answer.lowercased() ? .green : .red)
                        Text("回答: \(questions[index].answer)")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }
                Button("初めからやり直す") {
                    restartQuiz()
                }
                .padding()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            isQuizComplete = true
        }
    }

    private func restartQuiz() {
        currentQuestionIndex = 0
        userAnswer = ""
        userAnswers = [] // Clear all user answers
        score = 0
        isQuizComplete = false
    }
}
