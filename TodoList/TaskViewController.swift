//
//  TaskViewController.swift
//  TodoList
//
//  Created by Alexey Gaidykov on 30.11.2022.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var taks: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = taks
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
//        let newCount = count - 1
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "task_\(currentPosition)")

    }

}
