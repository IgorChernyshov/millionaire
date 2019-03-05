//
//  Hint.swift
//  millionaire
//
//  Created by Igor Chernyshov on 03/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This entity contains information about hint types.
///
/// - fiftyFifty: This hint removes half of incorrect answers.
/// - callFriend: This hint highlights a correct answer with a 75% possibility.
/// With a 25% possibility it highlights a random answer.
/// - audienceHelp: This hint distributes 70% of "votes" randomly between answers.
/// 30% are automatically added to correct answer.
enum Hint {
  case fiftyFifty, callFriend, audienceHelp
}
