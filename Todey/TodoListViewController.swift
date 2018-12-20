//
//  ViewController.swift
//  Todey
//
//  Created by Harsh Khetarpal on 20/12/18.
//  Copyright © 2018 Harsh Khetarpal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todolist = ["Buy Apple", "Buy iPhone XR", "Buy Rebook Shose", "Complete iOS Development Course"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todeycell", for: indexPath)
        
        cell.textLabel?.text = todolist[indexPath.row]
        
        return cell
        
    }
    
    // MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    // MARK - Bar Button 
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            self.todolist.append(textFieldValue.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Your New Item Hear"
            textFieldValue = textField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true)
        
    }
    


}

