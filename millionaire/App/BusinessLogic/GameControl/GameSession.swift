//
//  GameSession.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This class holds all the information regarding current game session.
/// Number of questions answered, total number of questions, what hints are available.
protocol GameSessionDelegate: AnyObject {
  /// Appends new result to the list of Game Results, sets current game session to nil.
  ///
  /// - Parameter percentOfQuestionsAnswered: This value is received from GameSessionDelegate.
  /// Represents the ratio between questions answered and total questions.
  func gameEnded(with percentOfQuestionsAnswered: Int)
}

final class GameSession {
  
  // MARK: - Variables
  
  private var questionsTotal: Int = 0
  var questionsAnswered = Observable<Int>(0)
  var percentOfQuestionsAnswered = Observable<Int>(0)
  
  private var usedFiftyFifty: Bool = false
  private var usedCallFriend: Bool = false
  private var usedAudienceHelp: Bool = false
  
  weak var sessionDelegate: GameSessionDelegate?

}

// MARK: - GameViewControllerDelegate
extension GameSession: GameViewControllerDelegate {
  
  func questionsForThisSession(total: Int) {
    questionsTotal = total
  }
  
  func answeredCorrect() {
    questionsAnswered.value += 1
    calculatePercentOfQuestionsAnswered()
  }
  
  func calculatePercentOfQuestionsAnswered() {
    guard questionsTotal != 0 else { return }
    
    let ratioAnsweredToNonAnswered: Float = Float(questionsAnswered.value) / Float(questionsTotal)
    percentOfQuestionsAnswered.value = Int(ratioAnsweredToNonAnswered * 100)
  }
  
  func gameEnded() {
    sessionDelegate?.gameEnded(with: percentOfQuestionsAnswered.value)
  }
  
  func used(hint: Hint) {
    switch hint {
    case .fiftyFifty:
      usedFiftyFifty = true
    case .callFriend:
      usedCallFriend = true
    case .audienceHelp:
      usedAudienceHelp = true
    }
  }
  
}
