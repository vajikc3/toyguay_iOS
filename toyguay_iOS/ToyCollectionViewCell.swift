//
//  ToyCollectionViewCell.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class ToyCollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView!
    var descriptionLabel: UILabel!
    var priceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        imageView = UIImageView()
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.backgroundColor = UIColor.lightGray.cgColor
        contentView.addSubview(imageView)

        descriptionLabel = UILabel()
        descriptionLabel.text = "Description..."
        descriptionLabel.font = descriptionLabel.font.withSize(11)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.textAlignment = .left
        descriptionLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
   //     descriptionLabel.backgroundColor = UIColor.white
        contentView.addSubview(descriptionLabel)
        
        priceLabel = UILabel()
        priceLabel.text = "€"
        priceLabel.font = priceLabel.font.withSize(11)
        priceLabel.textColor = UIColor.darkGray
        priceLabel.textAlignment = .right
   //     priceLabel.backgroundColor = UIColor.white
        contentView.addSubview(priceLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = imageView.frame
        frame.size.height = self.frame.size.height - 30
        frame.size.width = self.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        imageView.frame = frame
        
        var labelFrame = descriptionLabel.frame
        labelFrame.size.height = 30
        labelFrame.size.width = self.frame.size.width - 40
        labelFrame.origin.x = imageView.frame.origin.x + 5
        labelFrame.origin.y = imageView.frame.size.height
        descriptionLabel.frame = labelFrame
        
        labelFrame.size.width = 30
        labelFrame.origin.x = descriptionLabel.frame.size.width + 6
        priceLabel.frame = labelFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
