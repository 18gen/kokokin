import SwiftUI

struct QuizView: View {
    let questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var showScoreAlert = false
    @State private var isQuizComplete = false

    var body: some View {
        VStack {
            if !isQuizComplete {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.headline)
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .padding()
                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Submit") {
                    checkAnswer()
                }
                .padding()
            } else {
                Text("Quiz Complete!")
                    .font(.largeTitle)
                Text("Your Score: \(score) / \(questions.count)")
                    .font(.title)
                    .padding()
                Button("Restart Quiz") {
                    restartQuiz()
                }
                .padding()
            }
            Spacer()
        }
        .padding()
        .alert("Correct!", isPresented: $showScoreAlert) {
            Button("Next") { nextQuestion() }
        }
    }

    private func checkAnswer() {
        if userAnswer.lowercased() == questions[currentQuestionIndex].answer.lowercased() {
            score += 1
            showScoreAlert = true
        } else {
            nextQuestion()
        }
        userAnswer = ""
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
        score = 0
        userAnswer = ""
        isQuizComplete = false
    }
}
