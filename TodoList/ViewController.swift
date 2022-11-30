//
//  ViewController.swift
//  TodoList
//
//  Created by Alexey Gaidykov on 30.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [String]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTask()
    }
    
    func updateTask() {
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as? EntryViewController else { return }
        vc.title = " New Tasks"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTask()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return }
        vc.title = " New Tasks"
        vc.taks = tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
