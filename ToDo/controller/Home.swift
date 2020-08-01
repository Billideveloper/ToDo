//
//  Home.swift
//  ToDo
//
//  Created by Ravi Thakur on 27/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import UIKit

class Home: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    
    
    var todoitem = [Item]()
    
    let filepat = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadtasks()
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        if let items = defaults.array(forKey: "MyTasks") as? [Item]{
//            todoitem = items
//        }
        
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoitem.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath)
        
        let item = todoitem[indexPath.row]

        cell.textLabel?.text = item.title
        
        if item.cheacked == true{
            
            cell.accessoryType = .checkmark
            
        }else{
            
            cell.accessoryType = .none
        }
        

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoitem[indexPath.row])
        
        
        
        if todoitem[indexPath.row].cheacked == false{
            todoitem[indexPath.row].cheacked = true
        }else{
            todoitem[indexPath.row].cheacked = false
        }
       
        self.savetask()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func add_todo(_ sender: UIBarButtonItem) {
        
        var task = UITextField()
        
        
        let alert = UIAlertController(title: "add ToDo", message: "please add your actions or work", preferredStyle: UIAlertController.Style.alert)
        
        
        let action = UIAlertAction(title: "Add In Your Task", style: .default) { (action) in
            
        
            var new = Item()
            
            new.title = task.text!
            

            self.todoitem.append(new)
            
            self.savetask()
            
           
        }
        
        alert.addTextField { (alerttextfiled) in
            alerttextfiled.placeholder = "Add your Task here"
           task = alerttextfiled
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func savetask(){
        
        let encoder = PropertyListEncoder()
        
        
        do{
            let data = try encoder.encode(todoitem)
            
            try data.write(to: filepat!)
            
        }catch{
            print(error)
        }
        
        
        self.tableview.reloadData()
        
        
    }
    
    func loadtasks(){
        if let data = try? Data(contentsOf: filepat!){
            
        let decoder = PropertyListDecoder()
            do{
            todoitem = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error")
            }
        
        }
    }

}
