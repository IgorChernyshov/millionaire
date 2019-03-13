//
//  QuestionsModeStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This protocol allows to implement strategies that switches between default questions and custom questions.
/// Strategy can be changed on Options screen.
protocol QuestionsModeStrategy: AnyObject {
  
  /// Returns default questions file from app's sandbox or custom questions file from NSUserDefaults.
  ///
  /// - Returns: Decoded array of questions.
  func loadQuestions() -> [Question]
}
