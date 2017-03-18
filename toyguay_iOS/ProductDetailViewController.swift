//
//  ProductDetailViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 18/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import MapKit

class ProductDetailViewController: UIViewController {
    
    var product: Toy?

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productTitleLable: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var deleteProductButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTitleLable.text = product?.name ?? ""
        self.productDescriptionLabel.text = product?.descriptionText ?? ""
        self.priceLabel.text = "\(product?.price)"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var deleteProductAction: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
