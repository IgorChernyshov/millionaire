//
//  GameViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
  func questionsForThisSession(total: Int)
  func answeredCorrect()
  func answeredIncorrect()
  func used(hint: String)
}

final class GameViewController: UIViewController {
  
  // MARK: - Delegates
  
  weak var gameDelegate: GameViewControllerDelegate?
  
  // MARK: - Variables
  
  private var questions: [Question] = []
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerButtonA: UIButton!
  @IBOutlet weak var answerButtonB: UIButton!
  @IBOutlet weak var answerButtonC: UIButton!
  @IBOutlet weak var answerButtonD: UIButton!
  @IBOutlet weak var hintButtonFiftyFifty: UIButton!
  @IBOutlet weak var hintButtonCallFriend: UIButton!
  @IBOutlet weak var hintButtonAudienceHelp: UIButton!
  
  // MARK: - Controller's methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gameDelegate = Game.instance.gameSession
    loadQuestions()
    nextQuestion()
  }
  
  private func loadQuestions() {
    let decoder = JSONDecoder()
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
      let data: Data = try? NSData(contentsOf: url) as Data,
      let decodedData = try? decoder.decode(Questions.self, from: data) else {
        fatalError("Cannot load questions from disk!")
    }
    
    questions = decodedData.questions
    
    let questionsCount = questions.count
    gameDelegate?.questionsForThisSession(total: questionsCount)
  }
  
  private func nextQuestion() {
    resetButtons()
    
    guard let currentQuestion = questions.first else { return }
    
    questionLabel.text = currentQuestion.question
    answerButtonA.setTitle(currentQuestion.answers[0], for: .normal)
    answerButtonB.setTitle(currentQuestion.answers[1], for: .normal)
    answerButtonC.setTitle(currentQuestion.answers[2], for: .normal)
    answerButtonD.setTitle(currentQuestion.answers[3], for: .normal)
  }
  
  private func resetButtons() {
    answerButtonA.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    answerButtonA.isEnabled = true
    answerButtonB.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    answerButtonB.isEnabled = true
    answerButtonC.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    answerButtonC.isEnabled = true
    answerButtonD.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    answerButtonD.isEnabled = true
  }
  
  private func showGameOverAlert(withTitle title: String, andMessage message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okButton)
    
    present(alert, animated: true, completion: nil)
  }
  
  private func checkIfPlayerWon() {
    if questions.isEmpty {
      showGameOverAlert(withTitle: "Ура!🥳", andMessage: "Ты ответил правильно на все вопросы!")
    }
  }
  
  // MARK: - Button's methods
  
  @IBAction func answerButtonWasPressed(_ sender: UIButton) {
    guard let currentQuestion = questions.first else { return }
    
    if sender.tag == currentQuestion.correctAnswerNumber {
      gameDelegate?.answeredCorrect()
      questions.removeFirst()
      
      checkIfPlayerWon()
      nextQuestion()
    } else {
      gameDelegate?.answeredIncorrect()
      showGameOverAlert(withTitle: "Неверно", andMessage: "К сожалению, игра окончена 🙁")
    }
  }

  @IBAction func fiftyFiftyButtonWasPressed(_ sender: Any) {
    provideFiftyFiftyHint()
    
    gameDelegate?.used(hint: "fiftyFifty")
  }
  
  private func provideFiftyFiftyHint() {
    guard let currentQuestion = questions.first else { return }
    
    switch currentQuestion.correctAnswerNumber {
    case 0,2:
      answerButtonB.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
      answerButtonB.isEnabled = false
      answerButtonD.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
      answerButtonD.isEnabled = false
    case 1,3:
      answerButtonA.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
      answerButtonA.isEnabled = false
      answerButtonC.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
      answerButtonC.isEnabled = false
    default:
      return
    }
    
    hintButtonFiftyFifty.isEnabled = false
    hintButtonFiftyFifty.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
  }
  
  @IBAction func callFriendButtonWasPressed(_ sender: Any) {
    
    hintButtonCallFriend.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
    hintButtonCallFriend.isEnabled = false
    gameDelegate?.used(hint: "callFriend")
  }
  
  private func provideCallFriendHint() {
    
  }
  
  @IBAction func audienceHelpButtonWasPressed(_ sender: Any) {
    
    hintButtonAudienceHelp.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
    hintButtonAudienceHelp.isEnabled = false
    gameDelegate?.used(hint: "audienceHelp")
  }
}
