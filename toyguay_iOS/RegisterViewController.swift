//
//  RegisterViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 23/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
        let completeRegisterVC = CompleteRegisterViewController(nibName: nil, bundle: nil)
        completeRegisterVC.name = self.nameTextField.text ?? ""
        completeRegisterVC.password = self.passwordTextField.text ?? ""
        completeRegisterVC.email = self.emailTextField.text ?? ""
        self.show(completeRegisterVC, sender: nil)
    }

    @IBAction func escapeRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
