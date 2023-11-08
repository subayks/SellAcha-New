//
//  BagView.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class BagView: UIViewController {
    
    @IBOutlet weak var selectFulFilmentButton: UIButton!
    @IBOutlet weak var selectFulfilmentLabel: UILabel!
    @IBOutlet weak var buttonCreateProduct: UIButton!
    @IBOutlet weak var selectFilterTableViewCell: UITableView!
    @IBOutlet weak var ordersScrollView: UIScrollView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overAllFilterCollectionView: UICollectionView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonWelcomeBack: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    let vm = BagViewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonCreateProduct.titleLabel?.font = UIFont(name: "Noto Sans", size: 10)
        self.buttonSubmit.titleLabel?.font = UIFont(name: "Noto Sans", size: 10)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.overAllFilterCollectionView.collectionViewLayout = layout
        self.buttonSubmit.layer.cornerRadius = 10
        self.buttonCreateProduct.layer.cornerRadius = 10
        self.selectFilterTableViewCell.isHidden = true
        
        let tapGestureRecognizerForChevron = UITapGestureRecognizer(target: self, action: #selector(chevronTapped(tapGestureRecognizer:)))
           chevronImage.isUserInteractionEnabled = true
        chevronImage.addGestureRecognizer(tapGestureRecognizerForChevron)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        selectFulFilmentButton.layer.borderWidth = 1
        selectFulFilmentButton.layer.borderColor = UIColor.lightGray.cgColor
        selectFulFilmentButton.layer.cornerRadius = 10
        
        selectFilterTableViewCell.layer.cornerRadius = 5
        selectFilterTableViewCell.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.getProducts(endPoint: "/api/product?type=products")

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
        
        self.vm.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.ordersTableView.reloadData()
            }
        }
        
        self.vm.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.overAllFilterCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        DispatchQueue.main.async {
            let urlString = self.vm.retriveProfile()?.logo ?? ""
            if let webpURL = URL(string: urlString)  {
                self.profileImage.sd_setImage(with: webpURL)
            } else {
                self.profileImage.image = UIImage(named: "error_placeholder")
            }
        }
    }
    
    @IBAction func actionSearch(_ sender: Any) {
      

    }
    
    @objc func chevronTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.selectFilterTableViewCell.isHidden = false
    }
    
    @IBAction func actionSelectFulfilment(_ sender: Any) {
        self.selectFilterTableViewCell.isHidden = false
        self.selectFilterTableViewCell.reloadData()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProfileView") as! ProfileView
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionCreateProduct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProductVC") as! CreateProductVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

extension BagView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView {
            return self.vm.model?.posts?.data?.count == 0 ? 1:self.vm.model?.posts?.data?.count ?? 1
        } else {
            return self.vm.ordersDataModel?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ordersTableView {
            if self.vm.model?.posts?.data?.count == nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
                cell.textLabel?.text = ""
                return cell
            }
            if self.vm.model?.posts?.data?.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
                cell.textLabel?.text = "No Records Found"
                return cell
            } else {
                let cell = ordersTableView.dequeueReusableCell(withIdentifier: "BagTableViewCell") as! BagTableViewCell
                cell.vm = self.vm.getBagTableViewCellVM(index: indexPath.row)
                return cell
            }
        } else {
            let cell = selectFilterTableViewCell.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = vm.ordersDataModel?[indexPath.row].title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ordersTableView {
            if self.vm.model?.posts?.data?[indexPath.row].isSelected == true {
                self.vm.model?.posts?.data?[indexPath.row].isSelected = false
            } else {
                self.vm.model?.posts?.data?[indexPath.row].isSelected = true
            }
            self.ordersTableView.reloadRows(at:  [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
        } else {
            self.selectFilterTableViewCell.isHidden = true
            self.selectFulfilmentLabel.text = self.vm.ordersDataModel?[indexPath.row].title
        }
    }
}

extension BagView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.ordersDataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if self.vm.ordersDataModel?[indexPath.row].isSelected == true {
            cell.filtersName.textColor = UIColor.white
            cell.overView.backgroundColor = UIColor(named: "PrimaryColor")
        } else {
            cell.filtersName.textColor = UIColor.gray
            cell.overView.backgroundColor = UIColor.white
            cell.badgeCount.layer.cornerRadius = cell.badgeCount.frame.height/2
            cell.badgeCount.clipsToBounds = true
            cell.badgeCount.backgroundColor = UIColor.gray
            cell.badgeCount.tintColor = UIColor.white
            cell.BatchWidthConstraint.constant = 20
            cell.overView.layer.borderWidth = 0.5
            cell.overView.layer.borderColor = UIColor.lightGray.cgColor
        }
        cell.filtersName.text = self.vm.ordersDataModel?[indexPath.row].title
        cell.badgeCount.setTitle(self.vm.ordersDataModel?[indexPath.row].count, for: .normal)
        cell.overView.layer.cornerRadius = 5
        cell.badgeCount.titleLabel?.font = UIFont(name: "Noto Sans", size: 8)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm.isFilterClicked = true
        self.vm.ordersDataModel?[self.vm.previousIndex].isSelected = false
        self.vm.ordersDataModel?[indexPath.row].isSelected = true
        self.vm.previousIndex = indexPath.row
        
        DispatchQueue.main.async {
            self.overAllFilterCollectionView.reloadData()
        }
        
        if self.vm.ordersDataModel?[indexPath.row].title == "Publish" {
            self.vm.getProducts(endPoint: "/api/product?type=products")
        } else if self.vm.ordersDataModel?[indexPath.row].title == "Draft" {
            self.vm.getProducts(endPoint: "/api/products/2?type=products")
        } else if self.vm.ordersDataModel?[indexPath.row].title == "Incomplete" {
            self.vm.getProducts(endPoint: "/api/products/3?type=products")
        } else if self.vm.ordersDataModel?[indexPath.row].title == "Trash" {
            self.vm.getProducts(endPoint: "/api/products/0?type=products")
        } 
    }
}

