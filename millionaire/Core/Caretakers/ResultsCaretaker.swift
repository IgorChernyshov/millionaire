//
//  ResultsCaretaker.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/*
 This caretaker saves and loads results to/from UserDefaults.
*/

final class ResultsCaretaker {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let resultsKey = "results"
  
  func saveResults(_ results: [GameResult]) throws {
    let data = try self.encoder.encode(results)
    UserDefaults.standard.set(data, forKey: self.resultsKey)
  }
  
  func loadResults() throws -> [GameResult] {
    guard let data = UserDefaults.standard.data(forKey: self.resultsKey) else {
      return []
    }
    return try self.decoder.decode([GameResult].self, from: data)
  }
  
}
