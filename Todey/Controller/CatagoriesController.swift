//
//  CatagoriesController.swift
//  Todey
//
//  Created by Harsh Khetarpal on 10/01/19.
//  Copyright © 2019 Harsh Khetarpal. All rights reserved.
//

import UIKit
import CoreData

class CatagoriesController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
    }
    
    
    //MARK: - Table Deligate And Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catagoriesShow", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].title
        
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
           destinationVC.selectedCategories = categoryArray[indexPath.row]
        }
    }
    
    
    
    //MARK: - Add new Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (alertAction) in
          
            let newCategorey = Category(context: self.context)
            newCategorey.title = textFieldValue.text
            
            self.categoryArray.append(newCategorey)
            self.saveItem()
          
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter New Item"
            textFieldValue = textField
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true,completion: nil)
        
    }
    
    
    //MARK: - Save Items
    
    func saveItem(){
        
        do{
            try context.save()
        }catch{
            print("Error in Saving Data")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Load Items
    
    func loadItem(){
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error in Fatching Data")
        }
        
        tableView.reloadData()
        
    }
    

}
