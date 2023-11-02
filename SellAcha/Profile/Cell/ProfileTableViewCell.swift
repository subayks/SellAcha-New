//
//  ProfileTableViewCell.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var lableTitle: UILabel!
    @IBOutlet weak var profileIcon: UIImageView!
    
    var profileTableViewCellVM: ProfileTableViewCellVM? {
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
        self.lableTitle.text = self.profileTableViewCellVM?.profileDataItem.name
        self.profileIcon.image = UIImage(named: self.profileTableViewCellVM?.profileDataItem.image ?? "")
        self.profileIcon.layer.cornerRadius = 10
    }
}
