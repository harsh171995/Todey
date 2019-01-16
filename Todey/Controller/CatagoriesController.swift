//
//  CatagoriesController.swift
//  Todey
//
//  Created by Harsh Khetarpal on 10/01/19.
//  Copyright © 2019 Harsh Khetarpal. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoriesController: UITableViewController {
    
    let realm = try! Realm()
    
    // Result Category should be declared optional
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
    }
    
    
    //MARK: - Table Deligate And Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catagoriesShow", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].title ?? "No value"
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "itemshow", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        print()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print("hello")
           destinationVC.selectedCategories = categoryArray?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Add new Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (alertAction) in
          
            let newCategorey = Category()
            newCategorey.title = textFieldValue.text!
            
            self.save(category: newCategorey)
          
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter New Item"
            textFieldValue = textField
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true,completion: nil)
        
    }
    
    
    //MARK: - Save Items
    
    func save(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error in Saving Data")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Load Items
    
    func loadItem(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    

}
