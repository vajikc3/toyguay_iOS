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
                //  cell.imageView.image = UIImage.init(named: "train")
        return cell
    }
    
//    
//    var gridCollectionView: UICollectionView!
//    var gridLayout: GridLayout!
//    
//    var toys = [Toy]()
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
// 
//        self.implementGridLayout()
// //       self.view.insertSubview(gridCollectionView, at: 0)
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Register cell classes
//         self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        // Do any additional setup after loading the view.
//        
//        toys = [
//            Toy(name:"train", description:"1 It is train"),
//            Toy(name:"dot_blue", description: "2 It is a dot"),
//            Toy(name:"dot_green", description: "3 It is a dot"),
//            Toy(name:"dot_pink", description: "4 It is a dot"),
//            Toy(name:"train", description:"5 It is train"),
//            Toy(name:"dot_blue", description: "6 It is a dot"),
//            Toy(name:"dot_green", description: "7 It is a dot"),
//            Toy(name:"dot_pink", description: "8 It is a dot")]
//        
//    }
//    
//    func implementGridLayout(){
//        gridLayout = GridLayout()
//        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
//        gridCollectionView.backgroundColor = UIColor.brown
//        gridCollectionView.showsVerticalScrollIndicator = false
//        gridCollectionView.showsHorizontalScrollIndicator = false
//        gridCollectionView!.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        gridCollectionView.dataSource = self
//        gridCollectionView.delegate = self
//        
//    }
//
//    
//    
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.toys.count > 50{
//            return 50
//        } else{
//            print(self.toys.count)
//            return self.toys.count
//        }
//    }
//    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToyCollectionViewCell
//        cell.imageView.image = UIImage.init(named: self.toys[indexPath.row].name)
//        //  cell.imageView.image = UIImage.init(named: "train")
//        return cell
//    }
//
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    // MARK: UICollectionViewDelegate
//    
//    /*
//     // Uncomment this method to specify if the specified item should be highlighted during tracking
//     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment this method to specify if the specified item should be selected
//     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//     return false
//     }
//     
//     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//     return false
//     }
//     
//     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//     
//     }
//     */
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
    
}





    

    

