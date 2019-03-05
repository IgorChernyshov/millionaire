//
//  CustomQuestionsDisabledStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This strategy loads questions from default questions.json file
final class CustomQuestionsDisabledStrategy: QuestionsModeStrategy {
  
  func loadQuestions() -> [Question] {
    let decoder = JSONDecoder()
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
      let data: Data = try? NSData(contentsOf: url) as Data,
      let decodedData = try? decoder.decode(Questions.self, from: data) else {
        fatalError("Cannot load questions from disk!")
    }
    return decodedData.questions
  }
  
}
