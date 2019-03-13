//
//  AddCustomQuestionViewController.swift
//  millionaire
//
//  Created by Igor Chernyshov on 09/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class AddCustomQuestionViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Variables
  
  private var questions: [Question] = []
  
  // MARK: - Caretaker
  
  private let questionsCaretaker = CustomQuestionsCaretaker()
  
  // MARK: - Controller's methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    loadCustomQuestions()
  }
  
  func loadCustomQuestions() {
    questions = (try? questionsCaretaker.loadCustomQuestions()) ?? []
    tableView.reloadData()
  }
  
  // MARK: - Buttons methods
  
  @IBAction func backButtonWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveButtonWasPressed(_ sender: Any) {
    
  }
  
}

// MARK: - TableView Delegate

extension AddCustomQuestionViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "addCustomQuestionCell", for: indexPath) as? AddCustomQuestionCell
      else { return UITableViewCell() }
    cell.configure(with: questions[indexPath.row])
    return cell
  }
  
}
