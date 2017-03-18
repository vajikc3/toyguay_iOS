//
//  ProductsViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController {

    var gridLayout: GridLayout!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
    var toys = [Toy]()
    var filteredToys = [Toy]()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementGridLayout()
        self.view.sendSubview(toBack: pickerView)
        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.sortDescriptors = [(NSSortDescriptor(key: "name", ascending: true))]
        toys = try! sameOne.context.fetch(fr)
        
        self.contentView.insertSubview(collectionView, at: 1)

    }
    
    func implementGridLayout(){
        gridLayout = GridLayout()
        self.collectionView = UICollectionView.init(frame: CGRect(x: 10,
                                                                  y: 60,
                                                                  width: self.view.frame.width,
                                                                  height: self.view.frame.height), collectionViewLayout: gridLayout)
        self.collectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var frame = self.collectionView.frame
        frame.size.height = self.view.frame.size.height
        frame.size.width = self.view.frame.size.width - 20
        frame.origin.x = 10
        frame.origin.y = 60
        self.collectionView.frame = frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
//    override func filterContentForSearchText(_ searchText: String) {
//        filteredToys = toys.filter({ (toy : Toy) -> Bool in
//            return false
//           // return toy.name.lowercased().contains(searchText.lowercased())
//        })
//        print(filteredToys)
//        self.collectionView.reloadData()
//        /**   filteredCandies = candies.filter({( candy : Candy) -> Bool in
//         let categoryMatch = (scope == "All") || (candy.category == scope)
//         return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
//         })
//         tableView.reloadData()*/
//    }


}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.toys.count > 50{
            return 50
        } else{
            print(self.toys.count)
            return self.toys.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToyCollectionViewCell
        if let url = URL(string: self.toys[indexPath.row].imageURL!) {
            let session = URLSession(configuration: .default)
            let downloadImgTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading img: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        if let imageData = data {
                            
                            DispatchQueue.main.async {
                                cell.imageView.contentMode = .scaleAspectFit
                                cell.imageView.image = UIImage(data: imageData)
                            }
                           //                            collectionView.reloadData()
                        } else {
                            print("Couldn't get image")
                        }
                    } else {
                        print("Couldn't get a response")
                    }
                }
            }
            downloadImgTask.resume()
        }
        
        cell.descriptionLabel.text = self.toys[indexPath.row].name
        cell.priceLabel.text = NSString(format: "%.2f", self.toys[indexPath.row].price) as String

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC: ProductDetailViewController = ProductDetailViewController()
        productDetailVC.product = self.toys[indexPath.row]
        self.tabBarController?.present(productDetailVC, animated: true, completion: nil)
    }
}
