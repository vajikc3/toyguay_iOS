//
//  SearchViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar!
    var filtroButton : UIButton!
    var starButton: UIButton!

    
    // Modelo de pruebas
    var toys = [Toy]()
    var filteredToys = [Toy]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
        self.view.addSubview(searchController.searchBar)

        
        self.setupFiltroButton()
        self.view.addSubview(filtroButton)
        
        self.setupFavStar()
        self.view.addSubview(starButton)

        
        //Prueba de modelo
        toys = [
            Toy(name:"train", description:"1 It is train"),
            Toy(name:"dot_blue", description: "2 It is a dot"),
            Toy(name:"dot_green", description: "3 It is a dot"),
            Toy(name:"dot_pink", description: "4 It is a dot"),
            Toy(name:"train", description:"5 It is train"),
            Toy(name:"dot_blue", description: "6 It is a dot"),
            Toy(name:"dot_green", description: "7 It is a dot"),
            Toy(name:"dot_pink", description: "8 It is a dot")]
        
    }
    
    func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.definesPresentationContext = true
        
        searchController.dimsBackgroundDuringPresentation = false
   //     searchController.searchBar.sizeToFit()
     //   searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 3/4, height: 65)
      //  searchController.searchBar.showsCancelButton = true
        
    }
    
    
    func setupFiltroButton(){
        filtroButton = UIButton(frame: CGRect(x: searchController.searchBar.frame.width,
                                              y: searchController.searchBar.frame.origin.y,
                                              width: self.view.frame.width - searchController.searchBar.frame.width,
                                              height: searchController.searchBar.frame.height))
        filtroButton.setTitle("Filtro", for: .normal)
        
        filtroButton.backgroundColor = UIColor(colorLiteralRed: 201/256, green: 201/256, blue: 206/256, alpha: 0.96)
        filtroButton.addTarget(self, action: #selector(self.showFilters), for: .touchUpInside)
    }
    
    func setupFavStar(){
        starButton = UIButton(frame: CGRect(x: searchController.searchBar.frame.origin.x,
                                            y: searchController.searchBar.frame.origin.y,
                                            width: searchController.searchBar.frame.height,
                                            height: searchController.searchBar.frame.height))
        
        starButton.titleLabel?.font = UIFont(name: "system", size: 28.0)
        starButton.setTitleColor(UIColor.darkGray, for: .normal)
        starButton.setTitle("☆", for: .normal)
        starButton.titleLabel?.sizeToFit()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showFilters(){
        let filterVC = FilterTableViewController()
        self.addChildViewController(filterVC)
        filterVC.view.frame = CGRect(x: 0,
                                     y: self.view.frame.height/2,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height/2)
        self.view.addSubview(filterVC.view)
        filterVC.didMove(toParentViewController: self)
            //      self.present(filterVC, animated: true, completion: nil)
    //    present(filterVC, animated: true, completion: nil)
//        let presentationC = filterVC.popoverPresentationController
  //      presentationC?.sourceView = filtroButton
    //    presentationC?.sourceRect = CGRect(x: 0,
    //                                      y: self.view.frame.height/2,
      //                                    width: self.view.frame.width,
        //                                  height: self.view.frame.height/2)
  //      self.present(filterVC, animated: true, completion: nil)
    //    present(filterVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func filterContentForSearchText(_ searchText: String) {
      
     /**   filteredCandies = candies.filter({( candy : Candy) -> Bool in
            let categoryMatch = (scope == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()*/
    }
    
    


}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar){
        
        filterContentForSearchText(searchBar.text!)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.hidesNavigationBarDuringPresentation = false
    //    let searchBar = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
