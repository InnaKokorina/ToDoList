//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Inna Kokorina on 10.03.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
var categoryArray = [Category]()
    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    // MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    // MARK: - Manipulate Method
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving Category context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching Category context \(error)")
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            
        }
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Create new category"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
       
    }
    
    // MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}
