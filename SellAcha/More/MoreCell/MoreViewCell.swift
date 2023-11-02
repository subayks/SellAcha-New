//
//  MoreViewCell.swift
//  SellAcha
//
//  Created by Subaykala on 17/10/23.
//

import UIKit

class MoreViewCell: UITableViewCell {

    @IBOutlet weak var buttonTouch: UIButton!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var vm: MoreViewCellVM? {
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
        self.title.text = self.vm?.moreDataItem?.itemName
        self.profileImage.image = UIImage(named: self.vm?.moreDataItem?.icon ?? "")
        
        if self.vm?.moreDataItem?.showRow == true {
            self.chevronImage.image = UIImage(systemName: "chevron.down")
        } else {
            self.chevronImage.image = UIImage(systemName: "chevron.right")
        }
        
        if self.vm?.moreDataItem?.profileData?.count ?? 0 > 0 {
            self.chevronImage.isHidden = false
        } else {
            self.chevronImage.isHidden = true
        }
    }
}
