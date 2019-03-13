//
//  AddCustomQuestionViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 05/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

/// This view controller allows to add custom questions to the game.
final class AddCustomQuestionViewControllerOld: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var answerATextField: UITextField!
  @IBOutlet weak var answerBTextField: UITextField!
  @IBOutlet weak var answerCTextField: UITextField!
  @IBOutlet weak var answerDTextField: UITextField!
  @IBOutlet weak var correctAnswerNumberTextField: UITextField!
  
  
  // MARK: - Caretakers
  
  private var customQuestionsCaretaker =  CustomQuestionsCaretaker()
  
  // MARK: - Variables
  
  private var questions: [Question]?
  
  // MARK: - Controller's methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    view.addGestureRecognizer(tap)
    
    questions = try? customQuestionsCaretaker.loadCustomQuestions()
  }
  
  /// Dismisses keyboard on tap somewhere on view
  @objc func handleTap() {
    view.endEditing(true)
  }
  
  // MARK: - Button's methods
  
  @IBAction func backButtonWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveButtonWasPressed(_ sender: Any) {
    if textFieldsAreFilled() {
      guard let questionText = questionTextField.text,
        let answerAText = answerATextField.text,
        let answerBText = answerBTextField.text,
        let answerCText = answerCTextField.text,
        let answerDText = answerDTextField.text,
        let correctAnswerNumber = Int(correctAnswerNumberTextField.text ?? "") else { return }
      let question = Question(question: questionText,
                              answers: [answerAText, answerBText, answerCText, answerDText],
                              correctAnswerNumber: correctAnswerNumber + 1)
      
      questions?.append(question)
      try? customQuestionsCaretaker.saveCustomQuestions(questions ?? [])
      dismiss(animated: true, completion: nil)
    }
  }
  
  private func textFieldsAreFilled() -> Bool {
    var textFieldsFilled: Bool = true
    
    for textFieldTag in 1...5 {
      let textField = view.viewWithTag(textFieldTag) as? UITextField
      let selectedTextFieldIsEmpty = textField?.text != ""
      textFieldsFilled = textFieldsFilled && selectedTextFieldIsEmpty
    }
    
    return textFieldsFilled
  }
  
}
