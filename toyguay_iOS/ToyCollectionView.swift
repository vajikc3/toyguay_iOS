//
//  ToyCollectionView.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 11/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class ToyCollectionView: UICollectionView {
    
    var gridLayout: GridLayout!
    
    var toys = [Toy]()
    
    init(model: Array<Toy>) {
        super.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        self.implementGridLayout()
        self.collectionViewLayout = gridLayout
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func implementGridLayout(){
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.register(ToyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.dataSource = self
        self.delegate = self
        
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ToyCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
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
        let cell = self.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToyCollectionViewCell
    //    cell.imageView.image = UIImage.init(named: self.toys[indexPath.row].name)
        //  cell.imageView.image = UIImage.init(named: "train")
        return cell
    }
}
