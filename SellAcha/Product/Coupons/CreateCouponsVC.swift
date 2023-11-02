//
//  CreateCouponsVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CreateCouponsVC: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var CodeTF: UITextField!
    
    @IBOutlet weak var PercentageTF: UITextField!
    @IBOutlet weak var expiredDateLbl: UILabel!
    @IBOutlet weak var choseDateView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var createCouponsVM = CreateCouponsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.CodeTF.underlined(color: .systemGray3)
        self.PercentageTF.underlined(color: .systemGray3)
        self.choseDateView.isHidden = true
        self.datePicker.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTapped(tapGestureRecognizer:)))
        expiredDateLbl.isUserInteractionEnabled = true
        expiredDateLbl.addGestureRecognizer(tapGestureRecognizer)
        
        self.expiredDateLbl.text = "YYY-MM-dd"
        self.PercentageTF.keyboardType = .numberPad
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
                
        if self.createCouponsVM.model != nil {
            self.CodeTF.text = self.createCouponsVM.model?.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.createCouponsVM.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.createCouponsVM.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.createCouponsVM.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.createCouponsVM.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.createCouponsVM.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @objc func labelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.choseDateView.isHidden = false
        self.datePicker.isHidden = false
    }
    
    @objc func dateSelected() {
        self.expiredDateLbl.text = datePicker.date.toString(dateFormat: "YYYY-MM-dd")
        self.datePicker.isHidden = true
        self.choseDateView.isHidden = true
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if self.CodeTF.text != "" && self.PercentageTF.text != "" && expiredDateLbl.text != "YYY-MM-dd" {
            if self.PercentageTF.text?.count ?? 0 > 2 {
                let alert = UIAlertController(title: "Alert", message: "Please enter only 2 digit in percentage field", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if self.createCouponsVM.model != nil {
                self.createCouponsVM.editCoupons(coupon: self.CodeTF.text ?? "", percent: self.PercentageTF.text ?? "", date: expiredDateLbl.text ?? "", id: "\(self.createCouponsVM.model?.id ?? 0)")
            } else {
                self.createCouponsVM.createCoupons(coupon: self.CodeTF.text ?? "", percent: self.PercentageTF.text ?? "", date: expiredDateLbl.text ?? "")
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
