//
//  CouponsCell.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CouponsCell: UITableViewCell {

    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var couponsCellVM: CouponsCellVM? {
        didSet {
            self.setupView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        self.nameLabel.text = self.couponsCellVM?.model.name
     //   self.dateLabel.text =
    }

}
