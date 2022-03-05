//
//  ViewController.swift
//  ToDoList
//
//  Created by Inna Kokorina on 04.03.2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
let itemArray = ["task1", "task2", "task3", "task4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//MARK - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item
        return cell
    }
    
    // MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

