//
//  ViewController.swift
//  SellAcha
//
//  Created by Subaykala on 11/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hidePasswordImage: UIImageView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var signupLbl: UILabel!
    
    var viewwModel = LoginViewModel()
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.textFieldPassword.isSecureTextEntry = true
        
        logoImage.layer.borderWidth = 8
        logoImage.layer.borderColor = UIColor(named: "PrimaryColor")?.cgColor
        logoImage.layer.cornerRadius = logoImage.frame.height/2
        logoImage.clipsToBounds = true
        overView.layer.cornerRadius = 50
        buttonLogin.layer.cornerRadius = 15
//        textFieldPassword.addBottomBorder()
//        textfieldEmail.addBottomBorder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        signupLbl.isUserInteractionEnabled = true
        signupLbl.addGestureRecognizer(tap)
        
        let tapForgotPassword = UITapGestureRecognizer(target: self, action: #selector(ViewController.forgotPasswordclciked))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(tapForgotPassword)
        
        let tapEye = UITapGestureRecognizer(target: self, action: #selector(ViewController.iconAction))
        hidePasswordImage.isUserInteractionEnabled = true
        hidePasswordImage.addGestureRecognizer(tapEye)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewwModel.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.viewwModel.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.viewwModel.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.viewwModel.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.viewwModel.navigationClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
            }
        }
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
            let alert = UIAlertController(title: "Alert", message: "You are leaving application, are you sure?", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                if let url = URL(string: "https://sellacha.com"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    @objc func forgotPasswordclciked(sender:UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as? ResetPasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
     //   self.viewwModel.makeLogin(email: "storef@gmail.com", password: "12345678")
        if self.textfieldEmail.text != "" && self.textFieldPassword.text != "" {
            if !self.viewwModel.isValidEmail(self.textfieldEmail.text ?? "") {
                let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Email Id", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.viewwModel.makeLogin(email: self.textfieldEmail.text ?? "", password: self.textFieldPassword.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all Mandatory Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func iconAction(sender:UITapGestureRecognizer) {
        if iconClick {
            textFieldPassword.isSecureTextEntry = false
            self.hidePasswordImage.image = UIImage(named: "changepassword")
        } else {
            textFieldPassword.isSecureTextEntry = true
            self.hidePasswordImage.image = UIImage(named: "icn_hide_password")
        }
        iconClick = !iconClick
    }
}


extension UITextField {
    func underlined(color:UIColor){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
