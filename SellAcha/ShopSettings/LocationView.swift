//
//  LocationView.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import UIKit

class LocationView: UIViewController {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var postalLabel: UILabel!
    @IBOutlet weak var postalTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        self.saveButton.layer.cornerRadius = 10
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if companyTextField.text != "" && self.addressTextField.text != "" && self.cityTextField.text != "" && self.stateTextField.text != "" && self.postalTextField.text != "" && self.emailTextField.text != "" && self.phoneTextField.text != "" && self.descriptionTextView.text != "" {
            
            
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
