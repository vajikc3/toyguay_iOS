//
//  CompleteRegisterViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 15/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class CompleteRegisterViewController: UIViewController {
    
    var name: String?
    var email: String?
    var password: String?
    var latitude: String?
    var longitude: String?

    @IBOutlet weak var provinciaTF: UITextField!
    @IBOutlet weak var poblacionTF: UITextField!
    @IBOutlet weak var rPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        nameTF.text = self.name ?? ""
        passwordTF.text = password ?? ""
        emailTF.text = email ?? ""
    }

    
    func setLocation(latitude: Double, longitude: Double) {
        self.latitude = String(format: "%f", latitude)
        self.longitude = String(format: "%f", longitude)
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
        let registerDownloadable = RegisterDownloadable()
        registerDownloadable.setData(firstname: nameTF.text ?? "",
                                     lastname: lastNameTF.text ?? "",
                                     email: emailTF.text ?? "",
                                     username: userTF.text ?? "",
                                     password: passwordTF.text ?? "",
                                     rPassword: rPasswordTF.text ?? "",
                                     latitude: latitude ?? "",
                                     longitude: longitude ?? "",
                                     city: poblacionTF.text ?? "",
                                     province: provinciaTF.text ?? "",
                                     country: "Spain")
        registerDownloadable.postRegister { (ok, error) in
            if ok {
                print("registrado")
                User.usuario = User()
                User.usuario?.nombre = self.nameTF.text ?? ""

                self.dismiss(animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.alert(message: error ?? "Error")
                }
            }
        }
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAvatarPhotoAction(_ sender: Any) {
        
    }
}

extension CompleteRegisterViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
