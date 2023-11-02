//
//  CreateBrandsVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit
import Photos

class CreateBrandsVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var chooseFilebtn: UIButton!
    @IBOutlet weak var featureLbl: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var dropDownTable: UITableView!
    @IBOutlet weak var dropDownStack: UIStackView!
    
    var createBrandsVM = CreateBrandsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.dropDownTable.isHidden = true
        
        if createBrandsVM.model != nil {
            self.nameTF.text = self.createBrandsVM.model?.name
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(stackTapped(tapGestureRecognizer:)))
        dropDownStack.isUserInteractionEnabled = true
        dropDownStack.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.createBrandsVM.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.createBrandsVM.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.createBrandsVM.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.createBrandsVM.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.createBrandsVM.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.createBrandsVM.allowToPhotos = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionCreate(_ sender: Any) {
        if self.nameTF.text != "" {
            if self.createBrandsVM.model != nil {
                self.createBrandsVM.editBrand(name: self.nameTF.text ?? "", featured: self.featureLbl.text ?? "", file: "")
            } else {
                self.createBrandsVM.uploadProfilePic(name: self.nameTF.text ?? "", featured: self.featureLbl.text ?? "")
                //  self.createBrandsVM.createBrand(name: self.nameTF.text ?? "", featured: self.featureLbl.text ?? "", file: "")
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Fill Brand Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionChoosePic(_ sender: Any) {
        self.createBrandsVM.requestPhotoAccess()
    }
    
    @objc func stackTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dropDownTable.isHidden = false
    }
}

extension CreateBrandsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.createBrandsVM.status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropDownTable.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
        cell.textLabel?.text = self.createBrandsVM.status[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dropDownTable.isHidden = true
        self.featureLbl.text = self.createBrandsVM.status[indexPath.row]
    }
}

extension CreateBrandsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
            if let fileName = asset.value(forKey: "filename") as? String{
                self.fileNameLabel.text = fileName

            }
        }
        self.createBrandsVM.selectedImage = selectedImageFromPicker
        dismiss(animated: true)
    }
}
