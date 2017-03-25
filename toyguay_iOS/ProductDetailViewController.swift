//
//  ProductDetailViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 18/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import MapKit
import CoreData

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

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var bajaProductoButton: UIButton!

    @IBOutlet weak var adquirirProductoButton: UIButton!
    
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productTitleLable.text = product?.name ?? ""
        self.productDescriptionLabel.text = String(format: "%@", (product?.descriptionText)!)
        self.priceLabel.text = String(format: "%.2f€", (self.product?.price)!)
        self.userNameLabel.text = product?.username
        self.stateLabel.text = product?.state
        self.dateLabel.text = "\(product?.createdDate)"
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double((product?.latitude)!), longitude: Double((product?.longitude)!))
        self.mapView.addAnnotation(annotation)
        self.mapView.showAnnotations([annotation], animated: true)
        
        if (User.loggedUser() != nil) && (User.usuario?.nombre == product?.username){
            self.bajaProductoButton.isEnabled = true
            self.bajaProductoButton.isHidden = false
            self.adquirirProductoButton.isHidden = true
            self.adquirirProductoButton.isEnabled = false
        } else {
            self.bajaProductoButton.isEnabled = false
            self.bajaProductoButton.isHidden = true
            self.adquirirProductoButton.isHidden = false
            self.adquirirProductoButton.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func bajaProductoAction(_ sender: Any) {
        let id = (self.product?.id!)!
        let deleteToy = DeleteToy()
        deleteToy.setToyToDelete(toy_id: id)
        deleteToy.deleteToy { (ok: Bool) in
            print("Borrado \(ok)")
            if ok {
                let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
                fr.predicate = NSPredicate(format: "id == %@", id)
                fr.sortDescriptors = [(NSSortDescriptor(key: "id", ascending: true))]
                if let result = try? self.sameOne.context.fetch(fr) {
                    for object in result {
                        self.sameOne.context.delete(object)
                        print("Borrado en Core Data")
                    }
                }
            }
        }

        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.predicate = NSPredicate(format: "id == %@", (self.product?.id)!)
        fr.sortDescriptors = [(NSSortDescriptor(key: "id", ascending: true))]
        if let result = try? self.sameOne.context.fetch(fr) {
            for object in result {
                self.sameOne.context.delete(object)
                print("Borrado en Core Data")
            }
        }
        
        self.sameOne.save()
    }

    @IBAction func adquirirProductoAction(_ sender: Any) {
        
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
