//
//  NuevoViewController.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 24/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit

class NuevoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    
    @IBOutlet weak var bajaProductoButton: UIButton!
    @IBOutlet weak var adquirirProductoButton: UIButton!
    let pickerView = UIPickerView()
    let currencies = ["€", "$", "£", "¥"]
    let categories = ["Deportes", "Exterior", "Muñecas", "Construcciones", "Bebé", "Lógica"]
    var selectedCategories: [String]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        currencyTextField.inputView = pickerView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
        self.selectedCategories = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if User.loggedUser() == nil {
            let loginVC: LogInViewController = LogInViewController()
            self.tabBarController?.present(loginVC, animated: true, completion: nil)
        }
        self.bajaProductoButton.isEnabled = false
        self.bajaProductoButton.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        let toyUploadable = ToyUploadable()
        var catString = ""
        if (self.selectedCategories?.count)! > 0 {
            for cat in self.selectedCategories! {
                catString.append(cat + ",")
            }
            catString.remove(at: catString.index(before: catString.endIndex))
        }
        toyUploadable.setData(name: self.titleTextField.text!, description: self.descriptionTextField.text!, price: self.priceTextField.text!, categories: catString)
        toyUploadable.postNewToy(taskCallback: { (ok, error) in
            if ok {
                DispatchQueue.main.async {
                    self.alert(message: "Producto añadido a ToyGuay")
                }
                
            } else {
                DispatchQueue.main.async {
                    self.alert(message: "No se ha podido añadir tu producto")
                }
            }
        })
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.titleTextField.text = ""
        self.descriptionTextField.text = ""
        self.priceTextField.text = ""
        self.tableView.reloadData()
    }
    
    @IBAction func bajaProducto(_ sender: Any) {
    }

    @IBAction func adquirirProducto(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId: String = "cellId"
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.selectedCategories?.append((tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        if (self.selectedCategories?.count)! > 0 {
            for index in 0...(self.selectedCategories?.count)! - 1 {
                if self.selectedCategories?[index] == self.categories[indexPath.row] {
                    self.selectedCategories?.remove(at: index)
                }
            }
        }
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

extension NuevoViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
