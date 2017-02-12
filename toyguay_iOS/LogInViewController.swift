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
        self.trainAnimation()
    }
    
    
    // MARK: Custom Login
    
    @IBAction func customLogIn(_ sender: Any) {
        print("User \(username.text)")
        print("Password \(password.text)")
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
        }
    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
        print("Did log out of facebook")
    }
    
    
    // MARK: Register Button
    
    @IBAction func goToRegisterView(_ sender: Any) {
        let rVC = RegisterViewController()
        self.present(rVC, animated: true)
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
