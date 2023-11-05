//
//  OrderInfoCell.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class OrderInfoCell: UITableViewCell {

    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var docImage: UIImageView!
    @IBOutlet weak var amountValueLabel: UILabel!
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var fulfilmentStatusButton: UIButton!
    @IBOutlet weak var PaymentStatusButton: UIButton!
    @IBOutlet weak var CustomerNameValue: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalOrderLabel: UILabel!
    @IBOutlet weak var fulfilmentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderNo: UILabel!
    
    var orderInfoCellVM: OrderInfoCellVM? {
        didSet {
            self.setupValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.checkBoxImage.layer.borderWidth = 0.5
        self.checkBoxImage.layer.borderColor = UIColor.gray.cgColor
        self.PaymentStatusButton.layer.cornerRadius = 5
        self.fulfilmentStatusButton.layer.cornerRadius = 5
        self.overView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupValues() {
        self.orderNo.text = self.orderInfoCellVM?.model.orderNo
        self.PaymentStatusButton.setTitle(self.orderInfoCellVM?.model.status, for: .normal)
        
        if self.orderInfoCellVM?.model.status?.lowercased() == "pending" {
            self.PaymentStatusButton.backgroundColor = UIColor(red: 254/255, green: 192/255, blue: 3/255, alpha: 255/255)
        } else if self.orderInfoCellVM?.model.status?.lowercased() == "incomplete" {
            self.PaymentStatusButton.backgroundColor = .red
        } else if self.orderInfoCellVM?.model.status?.lowercased() == "completed" {
            self.PaymentStatusButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        }
        
        if self.orderInfoCellVM?.model.isSelected  == true {
            self.checkBoxImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            self.checkBoxImage.image = UIImage(systemName: "")
        }
       
        self.quantityValue.text =
        "\(String(describing: self.orderInfoCellVM?.model.orderItemsCount ?? 0))"
        let title = "₹" + "\(String(describing: self.orderInfoCellVM?.model.total ?? 0))"
        self.amountValueLabel.text = title
        
        self.dateLabel.text = self.orderInfoCellVM?.dateStringToFormattedDateString()
        self.CustomerNameValue.text = self.orderInfoCellVM?.model.customer?.name
    }

}
