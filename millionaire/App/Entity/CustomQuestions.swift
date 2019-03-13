//
//  CustomQuestions.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

/// This entity displays if custom questions are allowed.
///
/// - disabled: Only default questions are allowed.
/// - mixed: Default questions will be displayed along with custom questions.
/// - customOnly: Only custom questions are allowed.
enum CustomQuestions {
  case disabled, mixed, customOnly
}
