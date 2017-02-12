//
//  ProductsViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class ProductsViewController: SearchViewController {

    var gridCollectionView: UICollectionView!
    var gridLayout: GridLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.implementGridLayout()
        self.view.insertSubview(gridCollectionView, at: 0)

    }
    
    func implementGridLayout(){
        gridLayout = GridLayout()
        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        gridCollectionView.backgroundColor = UIColor.white
        gridCollectionView.showsVerticalScrollIndicator = false
        gridCollectionView.showsHorizontalScrollIndicator = false
        gridCollectionView!.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var frame = gridCollectionView.frame
        frame.size.height = self.view.frame.size.height
        frame.size.width = self.view.frame.size.width - 20
        frame.origin.x = 10
        frame.origin.y = 0
        gridCollectionView.frame = frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func filterContentForSearchText(_ searchText: String) {
        filteredToys = toys.filter({ (toy : Toy) -> Bool in
            return toy.name.lowercased().contains(searchText.lowercased())
        })
        print(filteredToys)
        self.gridCollectionView.reloadData()
        /**   filteredCandies = candies.filter({( candy : Candy) -> Bool in
         let categoryMatch = (scope == "All") || (candy.category == scope)
         return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
         })
         tableView.reloadData()*/
    }


}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.toys.count > 50{
            return 50
        } else{
            if searchController.isActive && searchController.searchBar.text != "" {
                return self.filteredToys.count
            }
            return self.toys.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToyCollectionViewCell
        if
            searchController.isActive && searchController.searchBar.text != "" {
            cell.imageView.image = UIImage.init(named: self.filteredToys[indexPath.row].name)
        } else {
            cell.imageView.image = UIImage.init(named: self.toys[indexPath.row].name)
        }
      //  cell.imageView.image = UIImage.init(named: "train")
        return cell
    }
}
