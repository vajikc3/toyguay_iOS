//
//  SearchViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contentView: UIView!
    var filtroButton : UIButton!
    var starButton: UIButton!

    
    // Modelo de pruebas
    var toys = [Toy]()
    var filteredToys = [Toy]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
        
        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.sortDescriptors = [(NSSortDescriptor(key: "name", ascending: true))]
        toys = try! sameOne.context.fetch(fr)
        


    }
//    
//    func filterContentForSearchText(_ searchText: String) {
//      
//     /**   filteredCandies = candies.filter({( candy : Candy) -> Bool in
//            let categoryMatch = (scope == "All") || (candy.category == scope)
//            return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()*/
//    }
//
    


}

//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar){
//        
//        filterContentForSearchText(searchBar.text!)
//    }
//}
//
//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        searchController.hidesNavigationBarDuringPresentation = false
//    //    let searchBar = searchController.searchBar
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//}
