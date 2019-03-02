//
//  GameSession.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/*
This class holds all the information regarding current game session.
Number of questions answered, total number of questions, what hints are available.
*/

protocol GameSessionDelegate: AnyObject {
  /// Appends new result to the list of Game Results, sets current game session to nil.
  ///
  /// - Parameter percentOfQuestionsAnswered: This value is received from GameSessionDelegate.
  /// Represents the ratio between questions answered and total questions.
  func gameEnded(with percentOfQuestionsAnswered: Int)
}

final class GameSession {
  
  // MARK: - Variables
  
  private var questionsAnswered: Int = 0
  private var questionsTotal: Int = 0
  private lazy var percentOfQuestionsAnswered: Int = {
    guard questionsTotal != 0 else { return 0 }
    
    let ratioAnsweredToNonAnswered: Float = Float(questionsAnswered) / Float(questionsTotal)
    let percentOfAnsweredToNonAnswered: Int = Int(ratioAnsweredToNonAnswered * 100)
    return percentOfAnsweredToNonAnswered
  }()
  
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
    questionsAnswered += 1
  }
  
  func answeredIncorrect() {
    sessionDelegate?.gameEnded(with: percentOfQuestionsAnswered)
  }
  
  func used(hint: String) {
    switch hint {
    case "fiftyFifty":
      usedFiftyFifty = true
    case "callFriend":
      usedCallFriend = true
    case "audienceHelp":
      usedAudienceHelp = true
    default:
      return
    }
  }
  
}
