//
//  QuestionsOrder.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This entity contains information about questions order.
///
/// - sequential: Questions are always played in the same order.
/// - random: Questions are played in a completely random order.
enum QuestionsOrder {
  case sequential, random
}
