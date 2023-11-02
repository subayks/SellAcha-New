//
//  BannerAdCell.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import UIKit

class BannerAdCell: UITableViewCell {
    
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var bagImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    var vm: BannerAdCellVM? {
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
        self.name.text = self.vm?.model?.name
    }

}
