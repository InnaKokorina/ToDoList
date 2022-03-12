//
//  ViewController.swift
//  ToDoList
//
//  Created by Inna Kokorina on 04.03.2022.
//

import UIKit
import RealmSwift


class ToDoListViewController: UITableViewController {
    let realm = try! Realm()
    var todoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
 
     
        
    }
    //MARK: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No ToDo Items"
        }
        return cell
    }
    
    // MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done.toggle()
                }
            } catch {
                print("error in selected item \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   // MARK: - delete items
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("error in selected item \(error)")
                }
            }
            tableView.reloadData()
            }
    }
    // MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFied = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add action", style: .default) { action in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write({
                        let newItem = Item()
                        newItem.title = textFied.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    })
                } catch {
                    print("Error saving Category context \(error)")
                }
                
            }
                
                self.tableView.reloadData()
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Create new item"
                textFied = alertTextField
                
            }
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
        
    }
    // MARK: - Manipulate method

    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
}
// MARK: - Search Bar Method
extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
