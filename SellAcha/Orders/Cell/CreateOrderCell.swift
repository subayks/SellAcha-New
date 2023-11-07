//
//  CreateOrderCell.swift
//  SellAcha
//
//  Created by apple on 25/10/23.
//

import UIKit
import SDWebImageWebPCoder

class CreateOrderCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var cartTF: UITextField!
    @IBOutlet weak var cartAddBtn: UIButton!
    
    var vm: BagTableViewCellVM? {
        didSet {
            self.setupValues()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cartTF.addBottomBorder()
        self.productImage.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func setupValues() {
        self.productLbl.text = self.vm?.model.title
        self.priceLbl.text = String(self.vm?.model.price?.price ?? 0)
        self.cartTF.text = "1"
        self.productImage.layer.cornerRadius = 5
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        let urlString = "https://\(String(describing: self.vm?.model.preview?.media?.url?.dropFirst(2) ?? ""))"
        if let webpURL = URL(string: urlString)  {
            DispatchQueue.main.async {
                self.productImage.sd_setImage(with: webpURL)
            }
        } else {
            self.productImage.image = UIImage(named: "error_placeholder")
        }
    }
}
