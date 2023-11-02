//
//  CreateCategoriesVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit
import Photos

class CreateCategoriesVC: UIViewController {
    
    @IBOutlet weak var imageNameField: UILabel!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var chooseFileBtn: UIButton!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var assignToField: UITextField!
    @IBOutlet weak var featuredField: UITextField!
    @IBOutlet weak var serviceField: UITextField!
    
        // declare Array in pickerview.
    
    let servicesArray = ["Product","Service","Both"]
    let featuredArray = ["Yes","No","Both"]
    let assignToMenuArray = ["Yes","No","Both"]
    
     // declare pickerviews.
    
    var servicePickerView = UIPickerView()
    var featuredPickerView = UIPickerView()
    var assignMenuPickerView = UIPickerView()
    
    var vm = CreateCategoriesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // textfield input to pickerview.
        serviceField.inputView = servicePickerView
        featuredField.inputView = featuredPickerView
        assignToField.inputView = assignMenuPickerView
        
        // adding delegates to pickerview.
        servicePickerView.delegate = self
        servicePickerView.dataSource = self
        featuredPickerView.delegate = self
        featuredPickerView.dataSource = self
        assignMenuPickerView.delegate = self
        assignMenuPickerView.dataSource = self
        
        // adding tag to pickerview
        servicePickerView.tag = 1
        featuredPickerView.tag = 2
        assignMenuPickerView.tag = 3
        // Do any additional setup after loading the view.
        
        // adding tint color
        
        serviceField.tintColor = UIColor.black
        assignToField.tintColor = UIColor.black
        featuredField.tintColor = UIColor.black
        
        if self.vm.model != nil {
            self.enterName.text = self.vm.model?.name
            if self.vm.model?.menuStatus == 1 {
                self.assignToField.text = "Yes"
            } else if self.vm.model?.menuStatus ==  0 {
                self.assignToField.text = "No"
            } else {
                self.assignToField.text = "Both"
            }
            
            if self.vm.model?.featured == 1 {
                self.featuredField.text = "Yes"
            } else if self.vm.model?.featured ==  0 {
                self.featuredField.text = "No"
            } else {
                self.featuredField.text = "Both"
            }
            
            if self.vm.model?.type == "Product" {
                self.serviceField.text = "Product"
            } else if self.vm.model?.type == "Service" {
                self.serviceField.text = "Service"
            } else {
                self.serviceField.text = "Both"
            }
         //   self.vm.selectedImage = UIImage()
        }
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
        
        self.vm.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.vm.allowToPhotos = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionChoosePic(_ sender: Any) {
        self.vm.requestPhotoAccess()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if self.enterName.text != "" && self.assignToField.text != "" &&  self.featuredField.text != "" && serviceField.text != "" {
            if self.vm.model != nil {
                self.vm.editCategories(name: self.enterName.text ?? "", type: self.serviceField.text ?? "", featured: self.featuredField.text ?? "", menuStatus: self.assignToField.text ?? "")
            } else {
                self.vm.createCategories(name: self.enterName.text ?? "", type: self.serviceField.text ?? "", featured: self.featuredField.text ?? "", menuStatus: self.assignToField.text ?? "")
                //  self.createBrandsVM.createBrand(name: self.nameTF.text ?? "", featured: self.featureLbl.text ?? "", file: "")
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Fill Brand Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension CreateCategoriesVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return servicesArray.count
        case 2:
            return featuredArray.count
        case 3:
            return assignToMenuArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return servicesArray[row]
        case 2:
            return featuredArray[row]
        case 3:
            return assignToMenuArray[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            serviceField.text = servicesArray[row]
            serviceField.resignFirstResponder()
        case 2:
            featuredField.text = featuredArray[row]
            featuredField.resignFirstResponder()
        case 3:
            assignToField.text = assignToMenuArray[row]
            assignToField.resignFirstResponder()
        default:
            return
        }
    }
}

extension CreateCategoriesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
            if let fileName = asset.value(forKey: "filename") as? String{
                self.imageNameField.text = fileName
            }
        }
        self.vm.selectedImage = selectedImageFromPicker
        dismiss(animated: true)
    }
}
