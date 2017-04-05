//
//  CollectionViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 8/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class CollectionViewController: CoreDataCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToyCollectionViewCell
        let toy = self.fetchedResultsController?.object(at: indexPath) as! Toy
        cell.descriptionLabel.text = toy.name
        return cell
    }
    
    
}





    

    

