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

 //   @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var tableViewContainerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
    var toys = [Toy]()
    var filteredToys = [Toy]()
    
    var categories: [String] = ["Bebé", "Deportes", "Exterior", "Construcciones", "Muñecas", "Lógica", "Playsets"]
    var distances: [String] = ["1", "5", "10", "50"]
    var selectedCategories:[String] = []
    var selectedDistances:[String] = []
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementGridLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductsViewController.refrescarCollectionView), name:  Notification.Name("myNotification"), object: nil)
        self.cargarArray()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
 
        
        self.collectionContainerView.addSubview(collectionView)
        self.view.sendSubview(toBack: self.tableViewContainerView)
    }
    
    func cargarArray(){
        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.sortDescriptors = [(NSSortDescriptor(key: "name", ascending: true))]
        toys = try! sameOne.context.fetch(fr)
        
    }
    
    func refrescarCollectionView() {
        self.cargarArray()
        self.collectionView.reloadData()
    }
    
    func implementGridLayout(){
        gridLayout = GridLayout()
        self.collectionView = UICollectionView.init(frame: collectionContainerView.frame, collectionViewLayout: gridLayout)
        self.collectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.bounces = true
        self.collectionView.alwaysBounceVertical = true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var frame = self.collectionView.frame
        frame.size.height = self.collectionContainerView.frame.size.height
        frame.size.width = self.collectionContainerView.frame.size.width - 20
        frame.origin.x = 10
        frame.origin.y = 20
        self.collectionView.frame = frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func filtrarResultados(_ sender: Any) {
        self.view.bringSubview(toFront: self.tableViewContainerView)
        self.searchBar.isUserInteractionEnabled = false
    }
 
    @IBAction func markFavorite(_ sender: Any) {
    }
    
    @IBAction func cancelarFiltros(_ sender: Any) {
        self.view.sendSubview(toBack: self.tableViewContainerView)
        self.tableView.reloadData()
        self.selectedDistances.removeAll()
        self.selectedCategories.removeAll()
    }
    
    @IBAction func aceptarFiltros(_ sender: Any) {
        // postear la query
        
    }
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

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Categorías"
        }
        return "Distancia"
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Int(self.categories.count)
        }
        return Int(self.distances.count)

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId: String = "cellId"
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.textLabel?.text = categories[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = distances[indexPath.row] + " km"
        }
        
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedCategories.append(self.categories[indexPath.row])
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedDistances.append(self.distances[indexPath.row])
        }

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        if indexPath.section == 0 {
            if (self.selectedCategories.count) > 0 {
                for index in 0...(self.selectedCategories.count) - 1 {
                    if self.selectedCategories[index] == self.categories[indexPath.row] {
                        self.selectedCategories.remove(at: index)
                    }
                }
            }

        } else {
            if (self.selectedDistances.count) > 0 {
                for index in 0...(self.selectedDistances.count) - 1 {
                    if self.selectedDistances[index] == self.categories[indexPath.row] {
                        self.selectedDistances.remove(at: index)
                    }
                }
            }
        }
    }
}
