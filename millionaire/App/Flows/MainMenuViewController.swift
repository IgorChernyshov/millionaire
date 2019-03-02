//
//  MainMenuViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {

  // MARK: - Button's methods
  
  @IBAction func playButtonWasPressed(_ sender: Any) {
    let newGameSession = GameSession()
    Game.instance.gameSession = newGameSession
    performSegue(withIdentifier: "toGameVC", sender: self)
  }

}
