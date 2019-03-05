//
//  GameViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
  /// Informs how many questions were loaded for this session.
  ///
  /// - Parameter total: Total number of questions for this game session.
  func questionsForThisSession(total: Int)
  
  /// Informs that player answered correct.
  func answeredCorrect()
  
  /// Informs that game ended.
  func gameEnded()

  /// Informs that player used a hint.
  ///
  /// - Parameter hint: Name of the hint that was used.
  func used(hint: Hint)
}

/// This view controller controls the game scene - shows questions, buttons with answers and allows to use hints.
final class GameViewController: UIViewController {
  
  // MARK: - Delegates
  
  weak var gameDelegate: GameViewControllerDelegate?
  
  // MARK: - Strategies
  
  private var questionsOrderStrategy: QuestionsOrderStrategy {
    switch Game.instance.questionsOrder {
    case .sequential:
      return SequentialQuestionsOrderStrategy()
    case .random:
      return RandomQuestionsOrderStrategy()
    }
  }
  
  // MARK: - Variables
  
  private var questions: [Question] = []
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var numberOfCorrectAnswersLabel: UILabel!
  @IBOutlet weak var percentsOfGameCompletedLabel: UILabel!
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
  
  /// Loads questions from questions.json and puts them into VC's array. Informs a delegate when ready.
  private func loadQuestions() {
    let decoder = JSONDecoder()
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
      let data: Data = try? NSData(contentsOf: url) as Data,
      let decodedData = try? decoder.decode(Questions.self, from: data) else {
        fatalError("Cannot load questions from disk!")
    }
    let loadedQuestions = decodedData.questions
    questions = questionsOrderStrategy.setOrder(of: loadedQuestions)
    
    let questionsCount = questions.count
    gameDelegate?.questionsForThisSession(total: questionsCount)
  }
  
  /// Displays next question to user.
  private func nextQuestion() {
    // TODO: Do only if 50:50 or Call a Friend hints were used.
    resetButtons()
    
    guard let currentQuestion = questions.first else { return }
    
    questionLabel.text = currentQuestion.question
    answerButtonA.setTitle(currentQuestion.answers[0], for: .normal)
    answerButtonB.setTitle(currentQuestion.answers[1], for: .normal)
    answerButtonC.setTitle(currentQuestion.answers[2], for: .normal)
    answerButtonD.setTitle(currentQuestion.answers[3], for: .normal)
  }
  
  /// Resets answer buttons title color and availability in case they were changed by hints.
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
  
  /// Shows a dismissable alert controller.
  ///
  /// - Parameters:
  ///   - title: A string that will be displayed in alert's title.
  ///   - message: A string that will be displayed in alert's message.
  private func showGameOverAlert(withTitle title: String, andMessage message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okButton)
    
    present(alert, animated: true, completion: nil)
  }
  
  /// Checks if player won the game.
  private func checkIfPlayerWon() {
    if questions.isEmpty {
      gameDelegate?.gameEnded()
      showGameOverAlert(withTitle: "Ура!🥳", andMessage: "Ты ответил правильно на все вопросы!")
    }
  }
  
  // MARK: - Button's methods
  
  /// Detects which button was pressed by tag and compares it with a correct answer.
  /// Moves to a next question if the answer is correct or says that the game is over in case of incorrect answer.
  ///
  /// - Parameter sender: UIButton that was pressed by user.
  @IBAction func answerButtonWasPressed(_ sender: UIButton) {
    guard let currentQuestion = questions.first else { return }
    
    if sender.tag == currentQuestion.correctAnswerNumber + 1 {
      gameDelegate?.answeredCorrect()
      questions.removeFirst()
      
      checkIfPlayerWon()
      nextQuestion()
    } else {
      gameDelegate?.gameEnded()
      showGameOverAlert(withTitle: "Неверно", andMessage: "К сожалению, игра окончена 🙁")
    }
  }

  /// Provides 50:50 hint to player. Informs a delegate that the hint was used.
  ///
  /// - Parameter sender: UIButton that was pressed by user.
  @IBAction func fiftyFiftyButtonWasPressed(_ sender: Any) {
    provideFiftyFiftyHint()
    
    gameDelegate?.used(hint: .fiftyFifty)
  }
  
  /// Disables 2 buttons that have incorrect answers.
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
  
  /// Provides Call a Friend hint to player. Informs a delegate that the hint was used.
  ///
  /// - Parameter sender: UIButton that was pressed by user.
  @IBAction func callFriendButtonWasPressed(_ sender: Any) {
    provideCallFriendHint()
    
    gameDelegate?.used(hint: .callFriend)
  }
  
  /// With a 75% chance changes correct answer's button text color to green.
  /// In other cases changes random button's text color to green.
  private func provideCallFriendHint() {
    // TODO: Fix that it can show answers that are disabled by 50/50
    guard let currentQuestion = questions.first else { return }
    
    // Roll a random number
    let randomBetweenOneAndHundred = Int.random(in: 1...100)
    // 75% chance that friend's answer is correct
    if randomBetweenOneAndHundred <= 75 {
      let correctButton = view.viewWithTag(currentQuestion.correctAnswerNumber + 1) as? UIButton
      correctButton?.setTitleColor(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), for: .normal)
    } else {
      // 25% chance that friend's answer is incorrect
      let randomButtonNumber = Int.random(in: 1...4)
      let randomButton = view.viewWithTag(randomButtonNumber) as? UIButton
      randomButton?.setTitleColor(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), for: .normal)
    }
    
    hintButtonCallFriend.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
    hintButtonCallFriend.isEnabled = false
  }
  
  /// Provides Audience Help hint to player. Informs a delegate that the hint was used.
  ///
  /// - Parameter sender: UIButton that was pressed by user.
  @IBAction func audienceHelpButtonWasPressed(_ sender: Any) {
    provideAudienceHelpHint()
    
    gameDelegate?.used(hint: .audienceHelp)
  }
  
  /// Splits 100% of "votes" randomly between answers and adds them to answer buttons titles.
  /// Correct answer will always have and additional 30% votes.
  private func provideAudienceHelpHint() {
    // TODO: Fix that it can show answers that are disabled by 50/50.
    guard let currentQuestion = questions.first else { return }
    var votesForAnswers = [0, 0, 0, 0]
    // Available votes are 70, because correct answer always gets additional 30 votes.
    var availableVotes = 70
    
    // Sets random part of available votes to answers. The last answer gets all that is left.
    for index in 1...3 {
      votesForAnswers[index - 1] += Int.random(in: 0...availableVotes)
      availableVotes -= votesForAnswers[index - 1]
    }
    votesForAnswers[3] += availableVotes
    votesForAnswers[currentQuestion.correctAnswerNumber] += 30
    
    // Adds votes number to buttons titles
    for index in 1...4 {
      let numberOfVotes = votesForAnswers[index - 1]
      let button = view.viewWithTag(index) as? UIButton
      var buttonTitle = button?.title(for: .normal)
      buttonTitle = "\(buttonTitle ?? "") - \(numberOfVotes)%"
      button?.setTitle(buttonTitle, for: .normal)
    }
    
    hintButtonAudienceHelp.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), for: .normal)
    hintButtonAudienceHelp.isEnabled = false
  }
}
