//
//  PerfilViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreData

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var comprasLabel: UILabel!
    @IBOutlet weak var ventasLabel: UILabel!
    @IBOutlet weak var localizationLabel: UILabel!
    
    var gridCollectionView: UICollectionView!
    var gridLayout: GridLayout!
    
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
    
    var toys = [Toy]()
    var notifications = [String]()

    var cv: UICollectionView!
    var searchTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.implementGridLayout()
        
        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.sortDescriptors = [(NSSortDescriptor(key: "name", ascending: true))]
        toys = try! sameOne.context.fetch(fr)
        
        cv = gridCollectionView
        self.implementTableView()
        self.collectionView.insertSubview(searchTV, at: 0)
        self.collectionView.insertSubview(cv, aboveSubview: searchTV)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if User.loggedUser() == nil {
            let loginVC: LogInViewController = LogInViewController()
            self.tabBarController?.present(loginVC, animated: true, completion: nil)
        } else {
            self.userNameLabel.text = User.usuario?.nombre
        }
        
    }

    
    
    @IBAction func newOptionSelected(_ sender: Any) {
        if segmentedCtrl.selectedSegmentIndex == 0 {
            self.gridCollectionView.sendSubview(toBack: searchTV)
        }
        if segmentedCtrl.selectedSegmentIndex == 1 {
            self.collectionView.sendSubview(toBack: searchTV)
        }
        if segmentedCtrl.selectedSegmentIndex == 2 {
            self.collectionView.sendSubview(toBack: cv)
        }
    }

    func implementGridLayout(){
        gridLayout = GridLayout()
        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        gridCollectionView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 208/255, alpha: 1.0)
        gridCollectionView.showsVerticalScrollIndicator = false
        gridCollectionView.showsHorizontalScrollIndicator = false
        gridCollectionView!.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        
    }
    
    func implementTableView(){
        
        self.notifications = ["Juguete en venta en radio 1km", "juguete en venta de MartinB", "Juguete para donar en radio 2 km"]
        searchTV = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        searchTV.dataSource = self
        searchTV.delegate = self
        var frame = self.containerView.frame
        frame.size.height = self.containerView.frame.size.height
        frame.size.width = self.containerView.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        searchTV.frame = frame
        searchTV.backgroundColor = UIColor.white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var frame = self.containerView.frame
        frame.size.height = self.containerView.frame.size.height
        frame.size.width = self.containerView.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        gridCollectionView.frame = frame
    }

}


extension PerfilViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
}

extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.notifications.count > 50{
            return 50
        } else{
            return self.notifications.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = notifications[indexPath.row]
        return cell!
    }
}
