//
//  EntryViewController.swift
//  TodoList
//
//  Created by Alexey Gaidykov on 30.11.2022.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTasks))
    }
    
    @objc func saveTasks() {
        guard let text = field.text, !text.isEmpty else { return }
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        navigationController?.popViewController(animated: true)
    }
}

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTasks()
        return true
    }
}
