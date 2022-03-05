//
//  ViewController.swift
//  ToDoList
//
//  Created by Inna Kokorina on 04.03.2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
var itemArray = ["task1", "task2", "task3", "task4"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = item
        }
        
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
    
    // MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFied = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add action", style: .default) { action in
        
            self.itemArray.append(textFied.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
          textFied = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
        
    }
}

