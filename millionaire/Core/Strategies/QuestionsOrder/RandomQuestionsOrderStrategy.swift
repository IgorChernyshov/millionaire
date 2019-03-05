//
//  RandomQuestionsOrderStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This strategy reorders questions array in a random way using default .shuffle() method.
final class RandomQuestionsOrderStrategy: QuestionsOrderStrategy {
  
  func setOrder(of questions: [Question]) -> [Question] {
    return questions.shuffled()
  }
  
}
