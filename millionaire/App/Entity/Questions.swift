//
//  Questions.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/*
This struct is codable and holds an array of Questions
*/

struct Questions: Codable {
  
  let questions: [Question]
  
}
