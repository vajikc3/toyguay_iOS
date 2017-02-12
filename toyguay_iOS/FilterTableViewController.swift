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
    
/*    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect(x: self.view.frame.width/5,
                                 y: self.view.frame.height/2,
                                 width: self.view.frame.width * 3/5,
                                 height: self.view.frame.height/2)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        categories = ["Cat 1", "Cat 2", "Cat 3", "Cat 4", "Cat 5"]
        distances = ["Distance 1","Distance 2","Distance 3","Distance 4","Distance 5","Distance 6","Distance 7"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
