//
//  OptionsViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

/// This view controller allows user to change various game options that are stored in Game singleton.
final class OptionsViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionsOrderSwitch: UISwitch!
  
  // MARK: - Controller's methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setQuestionsOrderSwitchPositionOnLaunch()
  }
  
  /// Checks what is current questions order and sets the switch accordingly.
  private func setQuestionsOrderSwitchPositionOnLaunch() {
    let isRandomQuestionsOrderSet = Game.instance.questionsOrder == .random
    questionsOrderSwitch.isOn = isRandomQuestionsOrderSet
  }
  
  // MARK: - Button's methods
  
  /// This method dismisses Options screen and navigates user back to Main Menu screen.
  ///
  /// - Parameter sender: UIButton that was pressed.
  @IBAction func backButtonWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  /// This method sets questions order in Game singleton on according UISwitch toggle.
  ///
  /// - Parameter sender: UISwitch that was toggled.
  @IBAction func randomQuestionsOrderSwitchWasToggled(_ sender: UISwitch) {
    // Switch label: Random questions order. Default value: Off.
    switch sender.isOn {
    case false:
      Game.instance.questionsOrder = .sequential
    case true:
      Game.instance.questionsOrder = .random
    }
  }
  
}
