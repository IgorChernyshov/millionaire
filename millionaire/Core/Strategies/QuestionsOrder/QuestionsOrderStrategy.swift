//
//  QuestionsOrderStrategy.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This protocol allows to implement strategies that manipulates with questions order.
/// Strategy can be changed on Options screen.
protocol QuestionsOrderStrategy: AnyObject {
  
  /// Sets questions in a specific order that is defined by a selected strategy.
  ///
  /// - Parameter questions: Array of questions that must be reordered.
  /// - Returns: Reordered array of questions.
  func setOrder(of questions:[Question]) -> [Question]
}
