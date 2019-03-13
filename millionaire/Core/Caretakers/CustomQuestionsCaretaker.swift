//
//  CustomQuestionsCaretaker.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This caretaker saves and loads custom questions to/from UserDefaults.
final class CustomQuestionsCaretaker {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let customQuestionsKey = "customQuestions"
  
  func saveCustomQuestions(_ questions: [Question]) throws {
    let data = try self.encoder.encode(questions)
    UserDefaults.standard.set(data, forKey: self.customQuestionsKey)
  }
  
  func loadCustomQuestions() throws -> [Question] {
    guard let data = UserDefaults.standard.data(forKey: self.customQuestionsKey) else {
      return []
    }
    return try self.decoder.decode([Question].self, from: data)
  }
  
}
