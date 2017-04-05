//
//  LogInViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 22/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.loggedUser() != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: Custom Login
    
    @IBAction func customLogIn(_ sender: Any) {
        
        let loginDownloadable = LoginDownloadable()
        loginDownloadable.setData(username: username.text ?? "", password: password.text ?? "")
        loginDownloadable.postLogin { (ok: Bool, token: String?) in
            if ok {
                User.usuario = User()
                User.usuario?.nombre = loginDownloadable.username
                User.usuario?.token = token
                print("login")
                DispatchQueue.main.async {
                   self.dismiss(animated: true, completion: nil)
                }

            }
        }
    }
    
    
    
    
    // MARK: Login with Facebook
    
    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        if error != nil{
            print (error)
            return
        } else {
            print("Successfully logged with Facebook")
            if User.loggedUser() != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        User.usuario = nil
        self.dismiss(animated: true, completion: nil)
        print("Did log out of facebook")
    }
    
    
    // MARK: Register Button
    
    @IBAction func goToRegisterView(_ sender: Any) {
        let rVC = RegisterViewController()
        self.present(rVC, animated: true)
    }
    
    @IBAction func goBackAction(_ sender: Any) {

        let alertController = UIAlertController(title: "Toyguay", message: "Debes ser usuario registrado para continuar", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        

    }
    
    // MARK: Animations
    
    public func trainAnimation(){
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: UIScreen.main.bounds.height/1.25))
        bezierPath.addLine(to: CGPoint(x: 435, y: UIScreen.main.bounds.height/1.25))
        let layer = CAShapeLayer()
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.black.cgColor
        
        self.view.layer.addSublayer(layer)
        
        let trainImageView = UIImageView(image: UIImage (named: "train"))
        trainImageView.frame = CGRect(x: 435 - trainImageView.frame.width/1.25,
                                      y: UIScreen.main.bounds.height/10 - trainImageView.frame.height/2,
                                      width: trainImageView.frame.width,
                                      height: trainImageView.frame.height)
    
        self.view.addSubview(trainImageView)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = bezierPath.cgPath
        animation.duration = 5.0
        animation.repeatCount = 0
 
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        trainImageView.layer.add(animation, forKey: "animation")
    }

}
