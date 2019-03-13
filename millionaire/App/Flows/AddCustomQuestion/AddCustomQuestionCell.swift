//
//  AddCustomQuestionCell.swift
//  millionaire
//
//  Created by Igor Chernyshov on 09/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class AddCustomQuestionCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var correctAnswerTextField: UITextField!
  @IBOutlet weak var answerATextField: UITextField!
  @IBOutlet weak var answerBTextField: UITextField!
  @IBOutlet weak var answerCTextField: UITextField!
  @IBOutlet weak var answerDTextField: UITextField!
  
  // MARK: - Variables
  
  let questionBuilder = AddCustomQuestionBuilder()
  
  // MARK: - Cell's methods
  
  func configure(with question: Question) {
    questionTextField.text = question.question
    correctAnswerTextField.text = String(question.correctAnswerNumber)
    answerATextField.text = question.answers[0]
    answerBTextField.text = question.answers[1]
    answerCTextField.text = question.answers[2]
    answerDTextField.text = question.answers[3]
  }
  
}

extension AddCustomQuestionCell: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField.tag {
    case 2:
      questionBuilder.setQuestion(questionTextField.text ?? "")
    case 3:
      questionBuilder.setAnswerA(answerATextField.text ?? "")
    case 4:
      questionBuilder.setAnswerB(answerBTextField.text ?? "")
    case 5:
      questionBuilder.setAnswerC(answerCTextField.text ?? "")
    case 6:
      questionBuilder.setAnswerD(answerDTextField.text ?? "")
    case 7:
      questionBuilder.setCorrectAnswer(Int(correctAnswerTextField.text ?? "0") ?? 0)
    default:
      return
    }
  }
  
}
