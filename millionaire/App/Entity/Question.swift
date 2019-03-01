//
//  Question.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

struct Question: Codable {
  
  let question: String
  let answers: [String]
  let correctAnswerNumber: Int
  
}
