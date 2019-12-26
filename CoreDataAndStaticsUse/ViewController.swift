//
//  ViewController.swift
//  CoreDataAndStaticsUse
//
//  Created by IMCS2 on 12/24/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var sendingLocation = [CoreDataModel]()
    var storedLocations : [CoreDataModel] = CorDataBase.fetching()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    @IBAction func addingAnItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add location", message: "Pleae add your name here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "Add your name here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Add number here"
            
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {textField in
            guard let name = alert.textFields?[0] else{return}
            guard let number = alert.textFields?[1] else{return}
            let names = CoreDataModel(name.text ?? "Nil", number.text ?? "Nil")
            self.sendingLocation.append(names)
            for index in self.sendingLocation{
            CorDataBase.saveData(index)
            }
        }))
        self.present(alert, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = storedLocations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction(style: .normal, title: "Delete", handler: { (_, _, _)  in
            self.deleteAction(indexPath)
        })
        let moreOption = UIContextualAction(style: .normal, title: "More", handler: {(_,_,_) in
            
            
        })
        moreOption.backgroundColor = .brown
        complete.backgroundColor = .red
        let action = UISwipeActionsConfiguration(actions: [complete, moreOption])
        action.performsFirstActionWithFullSwipe = true
        return action
        
    }
    
    
    

    
    func deleteAction(_ path: IndexPath){
        self.tableView.performBatchUpdates({
            CorDataBase.delete(storedLocations[path.row])
            self.storedLocations.remove(at: path.row)
            self.tableView.deleteRows(at: [path], with: .automatic)
        }, completion: {(_) in
            self.tableView.reloadData()
        })

    }
    
    
    
    @IBAction func fetchingData(_ sender: Any) {
        let storedLocations2 : [CoreDataModel] = CorDataBase.fetching()
        for i in storedLocations2{
            print(i.name)
        }
        
    }
}

