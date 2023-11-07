//
//  SubscriptionCell.swift
//  SellAcha
//
//  Created by Subaykala on 07/11/23.
//

import UIKit

class SubscriptionCell: UITableViewCell {
   
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var PaymentStatusButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var paymentMode: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var fulfilmentStatusButton: UIButton!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderNoLabel: UILabel!
    
    var vm: SubscriptionCellVM? {
        didSet {
            self.setupValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.PaymentStatusButton.layer.cornerRadius = 5
        self.fulfilmentStatusButton.layer.cornerRadius = 5
        self.overView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupValues() {
        self.orderNoLabel.text = self.vm?.model?.orderNo
        self.taxLabel.text = String(self.vm?.model?.tax ?? 0.0)
        self.totalLabel.text = String(self.vm?.model?.amount ?? 0.0)
        self.paymentMode.text = self.vm?.model?.category?.name
        self.expiryLabel.text = self.vm?.model?.willExpire
        self.purchaseDateLabel.text = self.vm?.dateStringToFormattedDateString()
        self.nameLabel.text = self.vm?.model?.plan?.name
        
        if self.vm?.model?.paymentStatus == 1 {
            self.PaymentStatusButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
            self.PaymentStatusButton.setTitle("PAID", for: .normal)
        } else if self.vm?.model?.paymentStatus == 2 {
            self.PaymentStatusButton.backgroundColor =  UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 255/255)
            self.PaymentStatusButton.setTitle("PENDING", for: .normal)
        }
        
        if self.vm?.model?.status == 1 {
            self.fulfilmentStatusButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
            self.fulfilmentStatusButton.setTitle("APPROVED", for: .normal)
        } else if self.vm?.model?.status == 2 {
            self.fulfilmentStatusButton.backgroundColor = .red
        } else if self.vm?.model?.status == 3 {
            self.fulfilmentStatusButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        } else {
            self.fulfilmentStatusButton.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 255/255)
        }
    }

}
