//
//  ViewController.swift
//  StoreApp
//
//  Created by user908662 on 1/12/18.
//  Copyright © 2018 user908662. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

     
        
      //  loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
      //  if let items = defaults.array(forKey: "Toidentify") as? [Item]{
        
       //    itemArray = items
       // }
        
    }
// TableView DateResource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Toidentify")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Toidentify", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
    
        return cell
    }
    
    // TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error Saving done status\(error)")
            }
        }
        tableView.reloadData()
        
    //    context.delete(TodoItems[indexPath.row])
      //  TodoItems.remove(at: indexPath.row)
      // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
      //  saveItems()
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
// BarButton Add
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                        
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                       
            let newItem = Item()
            newItem.title = textField.text!
            newItem.dateCreated = Date()
                        
                        
            currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items\(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
   /* func saveItems(){
        
       
        do {
            try context.save()
            
        }
        catch {
            print("Error Encoding Item Array, \(error)")
            
        }
        
        self.tableView.reloadData()
        
    } */
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
      /*  let categoryPredicate = NSPredicate(format: "patentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
        }
      
            do {
                itemArray = try context.fetch(request)
            }
            catch{
                print("Error Decoding item array, \(error)")
            }  */
     tableView.reloadData()
        }
   
        
    }
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
 todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
 
        tableView.reloadData()
 }
     /*   let request : NSFetchRequest<Item> = Item.fetchRequest()
        
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)*/
        
 
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
    




