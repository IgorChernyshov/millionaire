//
//  SequentialQuestionsOrderStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This strategy doesn't reorder questions array.
/// It returns the same array of questions every time.
final class SequentialQuestionsOrderStrategy: QuestionsOrderStrategy {
  
  func setOrder(of questions: [Question]) -> [Question] {
    return questions
  }
  
}
