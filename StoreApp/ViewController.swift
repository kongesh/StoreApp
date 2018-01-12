//
//  ViewController.swift
//  StoreApp
//
//  Created by user908662 on 1/12/18.
//  Copyright © 2018 user908662. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var item = ["lenovo","HCL","Honor","Micromax","Apple","samsung","Sony","Nokia","OnePlus","Vivo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
// TableView DateResource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Toidentify", for: indexPath)
        cell.textLabel?.text = item[indexPath.row]
        return cell
    }
    
    // TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            
            self.item.append(textField.text!)
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

