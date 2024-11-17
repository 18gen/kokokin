//
//  AutoSizingTextField.swift
//  kokokin
//
//  Created by Gen Ichihashi on 2024-11-16.
//

import SwiftUI

struct AutoSizingTextField: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8) // Padding inside the text field
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.backgroundColor = UIColor.systemGray6 // Light gray background
        textView.layer.cornerRadius = 8               // Rounded corners
        textView.layer.borderWidth = 1                // Outline thickness
        textView.layer.borderColor = UIColor.systemGray4.cgColor // Outline color
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: AutoSizingTextField

        init(_ parent: AutoSizingTextField) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
