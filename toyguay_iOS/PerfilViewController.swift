//
//  PerfilViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!

    var gridCollectionView: UICollectionView!
    var gridLayout: GridLayout!
    
    var toys = [Toy]()
    var boughtToys = [Toy]()
    var soldToys = [Toy]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementGridLayout()
        let cv = gridCollectionView
        
        
      //  self.view.insertSubview(collectionView, at: 0)
//        soldToys = [
//            Toy(name:"train", description:"1 It is train"),
//            Toy(name:"dot_blue", description: "2 It is a dot"),
//            Toy(name:"dot_green", description: "3 It is a dot"),
//            Toy(name:"dot_pink", description: "4 It is a dot"),
//            Toy(name:"train", description:"5 It is train"),
//            Toy(name:"dot_blue", description: "6 It is a dot"),
//            Toy(name:"dot_green", description: "7 It is a dot"),
//            Toy(name:"dot_pink", description: "8 It is a dot")]
//        boughtToys = [
//            Toy(name:"dot_green", description: "3 It is a dot"),
//            Toy(name:"dot_pink", description: "4 It is a dot"),
//            Toy(name:"train", description:"5 It is train")]
        self.collectionView.insertSubview(cv!, at: 0)
    }
    
    
    @IBAction func newOptionSelected(_ sender: Any) {
        if segmentedCtrl.selectedSegmentIndex == 0 {
            toys = soldToys
            gridCollectionView.reloadData()
        }
        if segmentedCtrl.selectedSegmentIndex == 1 {
            
        }
        if segmentedCtrl.selectedSegmentIndex == 2 {
            let searchTV = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            searchTV.dataSource = self
            searchTV.delegate = self
            self.collectionView.addSubview(searchTV)
        }
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
        frame.size.height = self.collectionView.frame.size.height
        frame.size.width = self.collectionView.frame.size.width - 20
        frame.origin.x = 10
        frame.origin.y = 0
        gridCollectionView.frame = frame
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    



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
        cell.imageView.image = UIImage.init(named: self.toys[indexPath.row].name!)
        //  cell.imageView.image = UIImage.init(named: "train")
        return cell
    }
}

extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.toys.count > 50{
            return 50
        } else{
            return self.toys.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = toys[indexPath.row].name
        return cell!
    }
}
