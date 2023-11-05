//
//  OrdersView.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class OrdersView: UIViewController {

    @IBOutlet weak var selectFulFilmentLabel: UILabel!
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
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2

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
        
        self.viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.overAllFilterCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        self.createorder.titleLabel?.font = UIFont(name: "Noto Sans", size: 10)
        self.buttonSubmit.titleLabel?.font = UIFont(name: "Noto Sans", size: 10)
        DispatchQueue.main.async {
            let url = URL(string: self.viewModel.retriveProfile()?.logo ?? "")
            do {
                let data = try? Data(contentsOf: url!)
                self.profileImage.image = UIImage(data: data!)
            } catch {
                
            }
        }
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
            self.selectFulFilmentLabel.text = self.viewModel.filterList[indexPath.row]
        }
    }
}

extension OrdersView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.ordersDataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if self.viewModel.ordersDataModel?[indexPath.row].isSelected == true {
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
        
        if  self.viewModel.ordersDataModel?[indexPath.row].ShowCount == true {
            cell.badgeCount.isHidden = false
            cell.BatchWidthConstraint.constant = 20
        } else {
            cell.badgeCount.isHidden = true
            cell.BatchWidthConstraint.constant = 0
        }
        cell.filtersName.text = self.viewModel.ordersDataModel?[indexPath.row].title
        cell.badgeCount.setTitle(self.viewModel.ordersDataModel?[indexPath.row].count, for: .normal)
        cell.overView.layer.cornerRadius = 5
        cell.badgeCount.titleLabel?.font = UIFont(name: "Noto Sans", size: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.viewModel.ordersDataModel?[self.viewModel.previousIndex].isSelected = false
        self.viewModel.ordersDataModel?[indexPath.row].isSelected = true
        self.viewModel.previousIndex = indexPath.row
        
        DispatchQueue.main.async {
            self.overAllFilterCollectionView.reloadData()
        }
        
        if self.viewModel.ordersDataModel?[indexPath.row].title == "Processing" {
            self.viewModel.getProcessingOrders(orderType: "processing")
        } else if self.viewModel.ordersDataModel?[indexPath.row].title  == "All" {
            self.viewModel.getAllOrders()
        } else if self.viewModel.ordersDataModel?[indexPath.row].title  == "Completed" {
            self.viewModel.getProcessingOrders(orderType: "completed")
        } else if self.viewModel.ordersDataModel?[indexPath.row].title  == "Cancelled" {
            self.viewModel.getProcessingOrders(orderType: "canceled")
        } else if self.viewModel.ordersDataModel?[indexPath.row].title  == "Archieved" {
            self.viewModel.getProcessingOrders(orderType: "archived")
        } else if self.viewModel.ordersDataModel?[indexPath.row].title  == "Ready For Pickup" {
            self.viewModel.getProcessingOrders(orderType: "pickup")
        }  else if self.viewModel.filterList[indexPath.row] == "Awaiting processing" {
         //   self.viewModel.getPendingOrders()
            self.viewModel.getProcessingOrders(orderType: "pending")
        } 
    }
}
