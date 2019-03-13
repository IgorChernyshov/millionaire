//
//  AddCustomQuestionBuilder.swift
//  millionaire
//
//  Created by Igor Chernyshov on 09/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

class AddCustomQuestionBuilder {
  
  // MARK: - Variables
  
  private(set) var question: String = ""
  private(set) var answerA: String = ""
  private(set) var answerB: String = ""
  private(set) var answerC: String = ""
  private(set) var answerD: String = ""
  private(set) var correctAnswerNumber: Int = 0
  
  // MARK: - Builder's methods
  
  func build() -> Question {
    return Question(question: question,
                    answers: [answerA, answerB, answerC, answerD],
                    correctAnswerNumber: correctAnswerNumber)
  }
  
  func setQuestion(_ question: String) {
    self.question = question
  }
  
  func setAnswerA(_ answer: String) {
    self.answerA = answer
  }
  
  func setAnswerB(_ answer: String) {
    self.answerB = answer
  }
  
  func setAnswerC(_ answer: String) {
    self.answerC = answer
  }
  
  func setAnswerD(_ answer: String) {
    self.answerD = answer
  }
  
  func setCorrectAnswer(_ correctAnswerNumber: Int) {
    self.correctAnswerNumber = correctAnswerNumber
  }
  
}
