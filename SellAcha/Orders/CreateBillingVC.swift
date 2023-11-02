//
//  CreateBillingVC.swift
//  SellAcha
//
//  Created by apple on 27/10/23.
//

import UIKit

class CreateBillingVC: UIViewController {
    
    @IBOutlet weak var OrderNoteTF: UITextField!
    
    @IBOutlet weak var paymentMethodView: UIView!
    
    @IBOutlet weak var cartItemView: UIView!
    
    @IBOutlet weak var shippingItemView: UIView!
    
    @IBOutlet weak var shippingZipView: UIView!
    
    @IBOutlet weak var paymentStatusView: UIView!
    
    @IBOutlet weak var TaxTF: UILabel!
    
    @IBOutlet weak var TotalTF: UILabel!
    
    @IBOutlet weak var promocodeTF: UITextField!
    
    @IBOutlet weak var customerNameTF: UITextField!
    
    @IBOutlet weak var customerEmailTF: UITextField!
    
    @IBOutlet weak var customerPhone: UITextField!
    
    @IBOutlet weak var customerTypeTF: UITextField!
    
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var zipTF: UITextField!
    
    @IBOutlet weak var selectDeliverytypeTF: UITextField!
    
    @IBOutlet weak var pendingBtn: UIButton!
    
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var addressTF: UnderlinedTextField!
    
    @IBOutlet weak var mobileBtn: UIButton!
    
    @IBOutlet weak var cashBtn: UIButton!
    
    @IBOutlet weak var paymentIDTF: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    // declaring picker views...
    
    var customerTypePickerView = UIPickerView()
    var deliveryTypePickerView = UIPickerView()
    var locationPickerView = UIPickerView()
    
    var vm = CreateBillingVM()
    // declare Array in pickerview.
    
    let customerTypeArray = ["Guest Customer","Website Customer"]
    let deliveryTypeArray = ["Handover Delivery","Virtual Delivery (Virtual Products)"]
    let locationArray = ["Chennai","Hyderabad","Bangalore"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        /*cartItemView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        shippingItemView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        shippingZipView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        paymentStatusView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        paymentMethodView.roundCorners(corners: [.topLeft , .topRight], radius: 30)*/
        
        // textfield input to pickerview.
        selectDeliverytypeTF.inputView = deliveryTypePickerView
        customerTypeTF.inputView = customerTypePickerView
        locationTF.inputView = locationPickerView
        
        // adding delegates to pickerview.
        deliveryTypePickerView.delegate = self
        deliveryTypePickerView.dataSource = self
        customerTypePickerView.delegate = self
        customerTypePickerView.dataSource = self
        locationPickerView.delegate = self
        locationPickerView.dataSource = self
        
        // adding tag to pickerview
        customerTypePickerView.tag = 1
        deliveryTypePickerView.tag = 2
        locationPickerView.tag = 3
        
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
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
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reedemAction(_ sender: Any) {
        if promocodeTF.text != "" {
            self.vm.redeemCoupon(coupon: self.promocodeTF.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill promotion code", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func pendingAction(_ sender: Any) {
        pendingBtn.setImage(UIImage(named: "radioOn"), for: .normal)
        completeBtn.setImage(UIImage(named: "radiOff"), for: .normal)
        self.vm.status = "1"
        
    }
    
    @IBAction func completeAction(_ sender: Any) {
        pendingBtn.setImage(UIImage(named: "radiOff"), for: .normal)
        completeBtn.setImage(UIImage(named: "radioOn"), for: .normal)
        self.vm.status = "2"
        
    }
    
    @IBAction func mobileAction(_ sender: Any) {
        mobileBtn.setImage(UIImage(named: "radioOn"), for: .normal)
        cashBtn.setImage(UIImage(named: "radiOff"), for: .normal)
        self.vm.payment = "1"
    }
    
    @IBAction func cashAction(_ sender: Any) {
        cashBtn.setImage(UIImage(named: "radioOn"), for: .normal)
        mobileBtn.setImage(UIImage(named: "radiOff"), for: .normal)
        self.vm.payment = "2"
    }
    
    @IBAction func makeOrderAction(_ sender: Any) {
        if  self.customerTypeTF.text != "" && self.selectDeliverytypeTF.text != "" && self.paymentIDTF.text != "" && self.customerNameTF.text != "" && self.customerEmailTF.text != "" && self.customerPhone.text != "" && self.addressTF.text != "" && self.zipTF.text != "" && self.locationTF.text != "" && self.vm.payment != nil && self.vm.status != "" {
            if !self.vm.isValidEmail(self.customerEmailTF.text ?? "") {
                let alert = UIAlertController(title: "Alert", message: "Please enter vaid Email Id", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.vm.createOrder(customerType: self.customerTypeTF.text ?? "", deliverType: self.selectDeliverytypeTF.text ?? "", shippingMethod: "240", paymentId: self.paymentIDTF.text ?? "", name: self.customerNameTF.text ?? "", email: self.customerEmailTF.text ?? "", phone: self.customerPhone.text ?? "", address: self.addressTF.text ?? "", zipCode: self.zipTF.text ?? "", location: self.locationTF.text ?? "", comment: self.OrderNoteTF.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension CreateBillingVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return customerTypeArray.count
        case 2:
            return deliveryTypeArray.count
        case 3:
            return locationArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return customerTypeArray[row]
        case 2:
            return deliveryTypeArray[row]
        case 3:
            return locationArray[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            customerTypeTF.text = customerTypeArray[row]
            customerTypeTF.resignFirstResponder()
        case 2:
            selectDeliverytypeTF.text = deliveryTypeArray[row]
            selectDeliverytypeTF.resignFirstResponder()
        case 3:
            locationTF.text = locationArray[row]
            locationTF.resignFirstResponder()
        default:
            return
        }
    }
    
    
}
