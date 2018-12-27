//
//  ViewController.swift
//  Todey
//
//  Created by Harsh Khetarpal on 20/12/18.
//  Copyright © 2018 Harsh Khetarpal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todolist = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newItem = Item()
        newItem.title = "Buy Apple"
        
        
        let newItem2 = Item()
        newItem2.title = "Buy Mangoes"
        
        let newItem3 = Item()
        newItem3.title = "Buy iPhone"
       
        todolist.append(newItem)
        todolist.append(newItem2)
        todolist.append(newItem3)
        
        if let item = defaults.array(forKey: "TodoeyList") as? [Item] {
            todolist = item
        }
        
       
    }
    
    //MARK - Table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "todeycell", for: indexPath)
        
        let newItem = todolist[indexPath.row]
        
        cell.textLabel?.text = newItem.title
        
        cell.accessoryType = newItem.done ? .checkmark : .none
       
        
        return cell
        
    }
    
    // MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Ternary Oprator
        todolist[indexPath.row].done = !todolist[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    // MARK - Bar Button 
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textFieldValue.text!
            
            self.todolist.append(newItem)
            
            self.defaults.set(self.todolist, forKey: "TodoeyList")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Your New Item Hear"
            textFieldValue = textField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        print("hello")
    }

}

