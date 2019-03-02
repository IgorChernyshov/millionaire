//
//  GameSession.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
  func gameEnded(with score: Int)
}

class GameSession {
  
  private var questionsSolved: Int = 0
  private var questionsTotal: Int = 0
  
  private var usedFiftyFifty: Bool = false
  private var usedCallFriend: Bool = false
  private var usedAudienceHelp: Bool = false
  
  weak var sessionDelegate: GameSessionDelegate?

}

extension GameSession: GameViewControllerDelegate {
  
  func questionsForThisSession(total: Int) {
    questionsTotal = total
  }
  
  func answeredCorrect() {
    questionsSolved += 1
  }
  
  func answeredIncorrect() {
    sessionDelegate?.gameEnded(with: questionsSolved)
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
