//
//  MainMenuViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

/// This view controller handles user's interaction with Main Menu.
final class MainMenuViewController: UIViewController {

  // MARK: - Button's methods
  
  /// Creates a new game session, assigns it to Game singleton and shows game screen.
  @IBAction func playButtonWasPressed(_ sender: Any) {
    let newGameSession = GameSession()
    Game.instance.gameSession = newGameSession
    performSegue(withIdentifier: "toGameVC", sender: self)
  }

}
