//
//  GameResult.swift
//  millionaire
//
//  Created by Igor Chernyshov on 02/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/*
This struct is codable and holds one result of the game: game's date and percent of questions answered.
*/

struct GameResult: Codable {
  
  let date: Date
  let percentOfQuestionsAnswered: Int
  
}
