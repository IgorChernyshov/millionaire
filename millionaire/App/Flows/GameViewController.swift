//
//  GameViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  // MARK: - Variables
  
  private var questions: [Question] = []
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerButtonA: UIButton!
  @IBOutlet weak var answerButtonB: UIButton!
  @IBOutlet weak var answerButtonC: UIButton!
  @IBOutlet weak var answerButtonD: UIButton!
  @IBOutlet weak var hintButton5050: UIButton!
  @IBOutlet weak var hintButtonCallFriend: UIButton!
  @IBOutlet weak var hintButtonAudienceHelp: UIButton!
  
  // MARK: - Controller's methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  }
  
  private func nextQuestion() {
    // TODO: Reset answer buttons state
    guard let currentQuestion = questions.first else { return }
    
    questionLabel.text = currentQuestion.question
    answerButtonA.setTitle(currentQuestion.answers[0], for: .normal)
    answerButtonB.setTitle(currentQuestion.answers[1], for: .normal)
    answerButtonC.setTitle(currentQuestion.answers[2], for: .normal)
    answerButtonD.setTitle(currentQuestion.answers[3], for: .normal)
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
    questions.removeFirst()
    if questions.isEmpty {
      showGameOverAlert(withTitle: "Ура!🥳", andMessage: "Ты ответил правильно на все вопросы!")
    }
  }
  
  // MARK: - Button's methods
  
  @IBAction func answerButtonWasPressed(_ sender: UIButton) {
    guard let currentQuestion = questions.first else { return }
    
    if sender.tag == currentQuestion.correctAnswerNumber {
      // TODO: Increase score
      checkIfPlayerWon()
      nextQuestion()
    } else {
      showGameOverAlert(withTitle: "Неверно", andMessage: "К сожалению, игра окончена 🙁")
    }
  }

}

