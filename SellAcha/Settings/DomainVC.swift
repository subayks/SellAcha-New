//
//  DomainVC.swift
//  SellAcha
//
//  Created by Subaykala on 27/10/23.
//

import UIKit
import Photos

class DomainVC: UIViewController {

    @IBOutlet weak var labelFileName: UILabel!
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var overView: UIView!
    var vm = DomainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.hideKeyboardWhenTappedAround()

        self.urlField.underlined(color: UIColor.lightGray)
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
                self.present(pickerController, animated: true)            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionChoosePic(_ sender: Any) {
        self.vm.requestPhotoAccess()
    }
    
    @IBAction func actionCreate(_ sender: Any) {
        if self.urlField.text != "" {
        //    self.vm.createBumpAd(url: self.urlField.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Enter Proper URL", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension DomainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
            if let fileName = asset.value(forKey: "filename") as? String{
                self.labelFileName.text = fileName

            }
        }
        self.vm.selectedImage = selectedImageFromPicker
        dismiss(animated: true)
    }
}
