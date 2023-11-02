//
//  OrdersView.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class OrdersView: UIViewController {

    @IBOutlet weak var createorder: UIButton!
    @IBOutlet weak var selectFulFilmentButton: UIButton!
    @IBOutlet weak var selectFilterTableViewCell: UITableView!
    @IBOutlet weak var filterOverView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overAllFilterCollectionView: UICollectionView!
    @IBOutlet weak var filterIcon: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonWelcomeBack: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    let viewModel = OrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.overAllFilterCollectionView.collectionViewLayout = layout
        self.buttonSubmit.layer.cornerRadius = 10
        self.createorder.layer.cornerRadius = 10
        self.filterIcon.layer.cornerRadius = 5
        self.selectFilterTableViewCell.isHidden = true
        let tapGestureRecognizerForFilter = UITapGestureRecognizer(target: self, action: #selector(filterTapped(tapGestureRecognizer:)))
        filterIcon.isUserInteractionEnabled = true
        filterIcon.addGestureRecognizer(tapGestureRecognizerForFilter)
        
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
        self.viewModel.getAllOrders()

        self.viewModel.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.viewModel.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.viewModel.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.viewModel.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.viewModel.reloadTableView = { [weak self] in
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
    
    @IBAction func actionCreateOrder(_ sender: Any) {
        let CreateOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateOrderVC") as! CreateOrderVC
        self.navigationController?.pushViewController(CreateOrderVC, animated: true)
    }
    
    @IBAction func actionFulfilment(_ sender: Any) {
        self.selectFilterTableViewCell.isHidden = false

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
}

extension OrdersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView {
            return self.viewModel.model?.orders?.data?.count == 0 ? 1:self.viewModel.model?.orders?.data?.count ?? 1
        } else {
            return self.viewModel.filterList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ordersTableView {
            if self.viewModel.model?.orders?.data?.count == 0 || self.viewModel.model?.orders?.data?.count == nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
                cell.textLabel?.text = "No Records Found"
                return cell
            } else {
                let cell = ordersTableView.dequeueReusableCell(withIdentifier: "OrderInfoCell") as! OrderInfoCell
                cell.orderInfoCellVM = self.viewModel.getOrderInfoCellVM(index: indexPath.row)
                return cell
            }
        } else {
            let cell = selectFilterTableViewCell.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = viewModel.filterList[indexPath.row]
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ordersTableView {
            if self.viewModel.model?.orders?.data?[indexPath.row].isSelected == true {
                self.viewModel.model?.orders?.data?[indexPath.row].isSelected = false
            } else {
                self.viewModel.model?.orders?.data?[indexPath.row].isSelected = true
            }
            self.ordersTableView.reloadRows(at:  [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
        } else {
            self.selectFilterTableViewCell.isHidden = true
           // self.selectFulfilmentLabel.text = self.viewModel.filterList[indexPath.row]
        }
    }
}

extension OrdersView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.filterList.count
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
        cell.filtersName.text = self.viewModel.filterList[indexPath.row]
        cell.overView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let previousCell = overAllFilterCollectionView.cellForItem(at: IndexPath(row: self.viewModel.previousIndex, section: indexPath.section))! as! FilterCell
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
        
        self.viewModel.previousIndex = indexPath.row
        if self.viewModel.filterList[indexPath.row] == "Processing" {
            self.viewModel.getProcessingOrders()
        } else if self.viewModel.filterList[indexPath.row] == "All" {
            self.viewModel.getAllOrders()
        } else if self.viewModel.filterList[indexPath.row] == "Completed" {
            
        } else if self.viewModel.filterList[indexPath.row] == "Cancelled" {
            
        } else if self.viewModel.filterList[indexPath.row] == "Archieved" {
            
        } else if self.viewModel.filterList[indexPath.row] == "Ready For Pickup" {
            
        }  else if self.viewModel.filterList[indexPath.row] == "Awaiting processing" {
            self.viewModel.getPendingOrders()
        } 
    }
}
