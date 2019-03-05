//
//  Game.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This is a singleton. It holds current game session.
/// It can save results via a caretaker.
final class Game: GameSessionDelegate {
  
  // MARK: - Variables
  
  var gameSession: GameSession? {
    didSet {
      gameSession?.sessionDelegate = self
    }
  }
  
  private(set) var gameResults: [GameResult] {
    didSet {
      try? resultsCaretaker.saveResults(gameResults)
    }
  }
  
  var questionsOrder: QuestionsOrder = .sequential
  var customQuestions: CustomQuestions = .disabled
  
  private let resultsCaretaker = ResultsCaretaker()
  
  // MARK: - Singleton initialization
  
  static let instance = Game()
  private init() {
    gameResults = (try? resultsCaretaker.loadResults()) ?? []
  }
  
  // MARK: - Methods

  func gameEnded(with percentOfQuestionsAnswered: Int) {
    let currentDate = Date()
    let newHighScoreRecord = GameResult(date: currentDate, percentOfQuestionsAnswered: percentOfQuestionsAnswered)
    
    gameResults.append(newHighScoreRecord)
    gameSession = nil
  }
  
}
