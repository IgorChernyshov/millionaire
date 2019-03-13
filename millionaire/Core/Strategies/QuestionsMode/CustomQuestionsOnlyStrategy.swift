//
//  CustomQuestionsOnlyStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This strategy loads custom questions from UserDefaults.
final class CustomQuestionsOnlyStrategy: QuestionsModeStrategy {
  
  /// Caretaker that can save and load custom questions.
  private let customQuestionsCaretaker = CustomQuestionsCaretaker()
  
  func loadQuestions() -> [Question] {
    if let questions = try? customQuestionsCaretaker.loadCustomQuestions() {
      return questions
    }
    return []
  }
  
}
