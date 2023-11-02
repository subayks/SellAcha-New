//
//  RatingCell.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var orderNoLabel: UILabel!
    
    var ratingCellVM: RatingCellVM? {
        didSet {
            self.setupValues()
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
    
    func setupValues() {
        self.amountLabel.text = self.ratingCellVM?.ratingData?.name
        self.orderNoLabel.text = "\(self.ratingCellVM?.ratingData?.rating ?? 0)"
    }

}
