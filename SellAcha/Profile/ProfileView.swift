//
//  ProfileView.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import UIKit

class ProfileView: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var emailIdView: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let vm = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //   curveView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        buttonBack.layer.cornerRadius = 10
        editButton.layer.cornerRadius = editButton.frame.height/2
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            do {
                let url = URL(string: self.vm.retriveProfile()?.logo ?? "")
                let data = try? Data(contentsOf: url!)
                self.profileImageView.image = UIImage(data: data!)
            } catch {
                
            }
        }
        self.emailIdView.text = self.vm.retriveUserDetails()?.email
        self.nameLabel.text = self.vm.retriveUserDetails()?.name
        
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
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let navigationController = UINavigationController(rootViewController: viewController )
                self.view.window?.rootViewController = navigationController
                self.view.window?.makeKeyAndVisible()
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
        
        self.vm.updateProfileImage = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.profileImageView.image = self.vm.selectedImage
            }
        }
        
        self.vm.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.emailIdView.text = self.vm.retriveUserDetails()?.email
                self.nameLabel.text = self.vm.retriveUserDetails()?.name
            }
        }
    }
    
    @IBAction func actionEdit(_ sender: Any) {
        self.vm.requestPhotoAccess()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.vm.title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.profileTableViewCellVM = self.vm.getProfileTableViewCellVM(index: indexPath.row)
        cell.accessoryView?.isHidden = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC
            vc.vm = self.vm.getUserDetailsVM(isFromSettings: false)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else if  indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC
            vc.vm = self.vm.getUserDetailsVM(isFromSettings: true)
            vc.updateProfileInfo = { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self else {return}
                    self.vm.getUserDetails()
                }
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)        } else {
                let alert = UIAlertController(title: "Alert", message: "Are you sure, You want to logout?", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertAction.Style.default, handler: { action in
                    UserDefaults.resetStandardUserDefaults()
                    if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
                    self.vm.getLogOut()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
    }
}
extension ProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        
        self.vm.selectedImage = selectedImageFromPicker
        dismiss(animated: true)
    }
}
