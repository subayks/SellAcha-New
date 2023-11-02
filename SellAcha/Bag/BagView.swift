//
//  BagView.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class BagView: UIViewController {
    
    @IBOutlet weak var buttonCreateProduct: UIButton!
    @IBOutlet weak var selectFilterTableViewCell: UITableView!
    @IBOutlet weak var filterOverView: UIView!
    @IBOutlet weak var ordersScrollView: UIScrollView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overAllFilterCollectionView: UICollectionView!
    @IBOutlet weak var filterIcon: UIImageView!
    @IBOutlet weak var selectFulfilmentLabel: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonWelcomeBack: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    let vm = BagViewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.getProducts()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.overAllFilterCollectionView.collectionViewLayout = layout
        self.buttonSubmit.layer.cornerRadius = 10
        self.buttonCreateProduct.layer.cornerRadius = 10
        self.filterIcon.layer.cornerRadius = 5
        self.selectFilterTableViewCell.isHidden = true
        
        let tapGestureRecognizerForFilter = UITapGestureRecognizer(target: self, action: #selector(filterTapped(tapGestureRecognizer:)))
        filterIcon.isUserInteractionEnabled = true
        filterIcon.addGestureRecognizer(tapGestureRecognizerForFilter)
        
        let tapGestureRecognizerForChevron = UITapGestureRecognizer(target: self, action: #selector(chevronTapped(tapGestureRecognizer:)))
           chevronImage.isUserInteractionEnabled = true
        chevronImage.addGestureRecognizer(tapGestureRecognizerForChevron)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
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
        
        self.vm.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.ordersTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionSearch(_ sender: Any) {
      

    }
    
    @objc func filterTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderFilterView") as! OrderFilterView
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
    }
    
    @objc func chevronTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.selectFilterTableViewCell.isHidden = false
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
            return self.vm.filterList.count
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
            cell.textLabel?.text = vm.filterList[indexPath.row]
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
            self.selectFulfilmentLabel.text = self.vm.filterList[indexPath.row]
        }
    }
}

extension BagView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if indexPath.row == 0 {
            cell.badgeCount.isHidden = true
            cell.filtersName.textColor = UIColor.white
            cell.overView.backgroundColor = UIColor(named: "PrimaryColor")
            cell.BatchWidthConstraint.constant = 0
        } else {
            cell.filtersName.textColor = UIColor.gray
            cell.overView.backgroundColor = UIColor.lightGray
            cell.badgeCount.layer.cornerRadius = cell.badgeCount.frame.height/2
            cell.badgeCount.clipsToBounds = true
            cell.badgeCount.backgroundColor = UIColor.gray
            cell.badgeCount.tintColor = UIColor.lightGray
            cell.BatchWidthConstraint.constant = 20
        }
        cell.filtersName.text = self.vm.filterList[indexPath.row]
        cell.overView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let previousCell = overAllFilterCollectionView.cellForItem(at: IndexPath(row: self.vm.previousIndex, section: indexPath.section))! as! FilterCell
        previousCell.filtersName.textColor = UIColor.gray
        previousCell.overView.backgroundColor = UIColor.lightGray
        previousCell.badgeCount.layer.cornerRadius = previousCell.badgeCount.frame.height/2
        previousCell.badgeCount.clipsToBounds = true
        previousCell.badgeCount.backgroundColor = UIColor.gray
        previousCell.badgeCount.tintColor = UIColor.lightGray
        previousCell.BatchWidthConstraint.constant = 20
        
        let cellToDeselect = overAllFilterCollectionView.cellForItem(at: indexPath)! as! FilterCell
        cellToDeselect.filtersName.textColor = UIColor.white
        cellToDeselect.overView.backgroundColor = UIColor(named: "PrimaryColor")
        
        self.vm.previousIndex = indexPath.row
        if self.vm.filterList[indexPath.row] == "Processing" {
            // self.vm.getProcessingOrders()
        } else if self.vm.filterList[indexPath.row] == "All" {
            self.vm.getProducts()
        } else if self.vm.filterList[indexPath.row] == "Completed" {
            
        } else if self.vm.filterList[indexPath.row] == "Cancelled" {
            
        } else if self.vm.filterList[indexPath.row] == "Archieved" {
            
        } else if self.vm.filterList[indexPath.row] == "Ready For Pickup" {
            
        }  else if self.vm.filterList[indexPath.row] == "Awaiting processing" {
          //  self.vm.getPendingOrders()
        }
    }
}

