//
//  ViewController.swift
//  Todey
//
//  Created by Harsh Khetarpal on 20/12/18.
//  Copyright © 2018 Harsh Khetarpal. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todolist : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategories : Category? {
        didSet{
            loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    // For accessing context from AppDelegate.swift
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // To get .sqlite file path
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //loadItem()
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    //MARK: - Table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "todeycell", for: indexPath)
        
        if let newItem = todolist?[indexPath.row] {
            
            cell.textLabel?.text = newItem.title
            
            cell.accessoryType = newItem.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Item Added"
        }
        return cell
    }
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // To Upadte item in database with realm
        
        if let item = todolist?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }catch {
                print("Error in Updating data")
            }
        }
        tableView.reloadData()
        
        
        // To delete data From database
        // Note:- First delete data from database then delete From Array
       // context.delete(todolist[indexPath.row])
        //todolist.remove(at: indexPath.row)
        
//        print(indexPath.row)
//        // Ternary Oprator
//        todolist?[indexPath.row].done = !todolist?[indexPath.row].done
//
//        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let item = todolist?[indexPath.row] {
            do{
                try realm.write {
                    // For delete an item
                    realm.delete(item)
                }
            } catch {
              print("Error in deleting items")
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - Bar Button
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
 
            if let currentCategory = self.selectedCategories {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textFieldValue.text!
                        newItem.dateCreated = Date()
                        currentCategory.item.append(newItem)
                        
                    }
                }catch{
                    print("Error in saving new items")
                }
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Your New Item Hear"
            textFieldValue = textField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true)
        
    }
    

    
    
    //MARK: - Save Data into the File
    
//    func save(items : Item){
//
//        do {
//            try realm.write {
//                realm.add(items)
//            }
//        }catch {
//            print("Error in saving Data \(error)")
//        }
//
//
//        tableView.reloadData()
//    }
    
    func loadItems(){
        
        todolist = selectedCategories?.item.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    

    
    // Load Otems Using Coredata
    
//    func loadItem(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//
//        let categoryPredicate = NSPredicate.init(format: "parentCategory.title MATCHES %@", selectedCategories!.title!)
//
//        if let addionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addionalPredicate])
//        }else {
//            request.predicate = categoryPredicate
//        }
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate])
////
////        request.predicate = compoundPredicate
//
//        do {
//            todolist = try context.fetch(request)
//        }catch{
//            print("Error Fatching data \(error)")
//        }
//
//        tableView.reloadData()
//    }

}

//MARK: - Search Bar Method
extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todolist = todolist?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        searchBar.resignFirstResponder()
//        loadItem(with: request, predicate: predicate)

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }else {
//            let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//            loadItem(with: request)
            
        }
    }
}

