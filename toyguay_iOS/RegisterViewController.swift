//
//  RegisterViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 23/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreLocation

class RegisterViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var locationManager: CLLocationManager!
    
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
           
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        self.longitude = userLocation.coordinate.longitude;
        self.latitude = userLocation.coordinate.latitude;
    
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
        let completeRegisterVC = CompleteRegisterViewController(nibName: nil, bundle: nil)
        completeRegisterVC.name = self.nameTextField.text ?? ""
        completeRegisterVC.password = self.passwordTextField.text ?? ""
        completeRegisterVC.email = self.emailTextField.text ?? ""
        completeRegisterVC.setLocation(latitude: self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        self.show(completeRegisterVC, sender: nil)
    }

    @IBAction func escapeRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
