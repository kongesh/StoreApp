//
//  ViewController.swift
//  StoreApp
//
//  Created by user908662 on 1/12/18.
//  Copyright © 2018 user908662. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Make"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = " Make"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find"
        itemArray.append(newItem3)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "Toidentify") as? [String]{
        
           item = items
        }
        
    }
// TableView DateResource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Toidentify")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Toidentify", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
       /* if item.done == true
        {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }*/
        
        return cell
    }
    
    // TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none       }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
// BarButton Add
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
                
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "Toidentify")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    


}

