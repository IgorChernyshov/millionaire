//
//  Game.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

class Game: GameSessionDelegate {
  
  // MARK: - Variables
  var gameSession: GameSession? {
    didSet {
      gameSession?.sessionDelegate = self
    }
  }
  var gameResults: [GameResult]?
  
  // MARK: - Singleton initialization
  static let instance = Game()
  private init() {}
  
  // MARK: - Methods
  
  func gameEnded(with score: Int) {
    let currentDate = Date()
    let newResult = GameResult(date: currentDate, score: score)
    
    gameResults?.append(newResult)
    gameSession = nil
  }
  
}
