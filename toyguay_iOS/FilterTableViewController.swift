//
//  FilterTableViewTableViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 28/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    

    
    var categories = [String]()
    var distances = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = ["Cat 1", "Cat 2", "Cat 3", "Cat 4", "Cat 5"]
        distances = ["Distance 1","Distance 2","Distance 3","Distance 4","Distance 5","Distance 6","Distance 7"]
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else if section == 1 {
            return distances.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = categories[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = distances[indexPath.row]
        }
        
        return cell
    }

}
