//
//  ChangePasswordVC.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var passwordScrollView: UIScrollView!
    @IBOutlet weak var enterAgainTextField: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    var vm = ChangePasswordVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.oldPasswordTextField.underlined(color: UIColor.lightGray)
        self.newPasswordTextField.underlined(color: UIColor.lightGray)
        self.enterAgainTextField.underlined(color: UIColor.lightGray)
        self.buttonSave.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.vm.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.vm.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.vm.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.vm.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.vm.navigationClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.dismiss(animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    //    overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if self.oldPasswordTextField.text != "" && self.newPasswordTextField.text != "" && self.enterAgainTextField.text != "" && (self.newPasswordTextField.text == self.enterAgainTextField.text) {
            self.vm.updatePassword(password: self.newPasswordTextField.text ?? "", currentPassword: self.oldPasswordTextField.text ?? "")
        }
    }
}
