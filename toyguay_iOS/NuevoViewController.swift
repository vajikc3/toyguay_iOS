//
//  NuevoViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class NuevoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    
    let pickerView = UIPickerView()
    let currencies = ["€", "$", "£", "¥"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        currencyTextField.inputView = pickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        pickerView.isHidden = false
        return false
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

extension NuevoViewController: UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}

extension NuevoViewController: UIPickerViewDelegate{
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return currencies[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        currencyTextField.text = currencies[row]
        currencyTextField.resignFirstResponder()
    }

}
