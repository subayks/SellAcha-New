//
//  CreateProductVC.swift
//  SellAcha
//
//  Created by apple on 27/10/23.
//

import UIKit
import Photos

class CreateProductVC: UIViewController {
    
    @IBOutlet weak var selectedFileLbl: UILabel!
    
    @IBOutlet weak var stockStatusTF: UITextField!
    
    @IBOutlet weak var productTitleTF: UITextField!
    
    @IBOutlet weak var stockQtyTF: UITextField!
    
    @IBOutlet weak var stockSwitch: UISwitch!
    
    @IBOutlet weak var skuTF: UITextField!
    
    @IBOutlet weak var priceTF: UITextField!
    
    @IBOutlet weak var specialPriceTF: UITextField!
    
    @IBOutlet weak var priceTypeTF: UITextField!
    
    @IBOutlet weak var priceStartsTF: UITextField!
    
    @IBOutlet weak var priceEndTF: UITextField!
    
    @IBOutlet weak var logoImg: UIImageView!
    
    // declaring datepicker...
    let datePicker = UIDatePicker()
    var priceTypePickerView = UIPickerView()
    var stockStatusPickerView = UIPickerView()
    let priceTypeArray = ["Fixed","Percentage"]
    let stockStatusArray = ["In Stock","Out of Stock"]
    
    var viewwModel = CreateProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        priceTypeTF.inputView = priceTypePickerView
        stockStatusTF.inputView = stockStatusPickerView
        priceTypePickerView.delegate = self
        priceTypePickerView.dataSource = self
        stockStatusPickerView.delegate = self
        stockStatusPickerView.dataSource = self
        priceTypePickerView.tag = 1
        stockStatusPickerView.tag = 2
        showStartDatePicker()
        showEndDatePicker()
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
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.viewwModel.allowToPhotos = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)            }
        }
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showStartDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        priceStartsTF.inputAccessoryView = toolbar
        priceStartsTF.inputView = datePicker
    }
    
    func showEndDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EnddonedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(EndcancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        priceEndTF.inputAccessoryView = toolbar
        priceEndTF.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        priceStartsTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func EnddonedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        priceEndTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func EndcancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func chooseFileBtn(_ sender: Any) {
        self.viewwModel.requestPhotoAccess()
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        if productTitleTF.text == ""{
            alert(message: "Please Enter Title")
        }else if priceTF.text == ""{
            alert(message: "Please Enter Price")
        }else if priceStartsTF.text == ""{
            alert(message: "Please Enter Start Date")
        }else if priceEndTF.text == ""{
            alert(message: "Please Enter End Date")
        }else if specialPriceTF.text == ""{
            alert(message: "Please Enter Special Price")
        }else{
            self.viewwModel.createProduct(title: "\(productTitleTF.text ?? "")", price: "\(priceTF.text ?? "")", specialprice: "\(specialPriceTF.text ?? "")", pricetype: "\(priceTypeTF.text ?? "")", specialpricestart: "\(priceStartsTF.text ?? "")", specialpriceend: "\(priceEndTF.text ?? "")", status: "\(stockStatusTF.text ?? "")")
        }
    }
}


extension CreateProductVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return priceTypeArray.count
        case 2:
            return stockStatusArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return priceTypeArray[row]
        case 2:
            return stockStatusArray[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            priceTypeTF.text = priceTypeArray[row]
            priceTypeTF.resignFirstResponder()
        case 2:
            stockStatusTF.text = stockStatusArray[row]
            stockStatusTF.resignFirstResponder()
        default:
            return
        }
    }
}
extension CreateProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
            if let fileName = asset.value(forKey: "filename") as? String{
                self.selectedFileLbl.text = fileName
            }
        }
        DispatchQueue.main.async {
            self.logoImg.image = selectedImageFromPicker
        }
        self.viewwModel.selectedImage = selectedImageFromPicker
        dismiss(animated: true)
    }
}
