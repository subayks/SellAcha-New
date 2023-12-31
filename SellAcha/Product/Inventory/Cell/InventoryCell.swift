//
//  InventoryCell.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit
import SDWebImageWebPCoder

class InventoryCell: UITableViewCell {

    @IBOutlet weak var inventoryImage: UIImageView!
    @IBOutlet weak var ProductLbl: UILabel!
    @IBOutlet weak var skuLbl: UILabel!
    @IBOutlet weak var stockManageBtn: UILabel!
    
    var inventoryCellVM: InventoryCellVM? {
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

        
    }
    
    func setupValues() {
        self.skuLbl.text = self.inventoryCellVM?.model.sku
        if self.inventoryCellVM?.model.stockStatus == 1 {
            self.stockManageBtn.text = "Yes"
            self.stockManageBtn.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        } else {
            self.stockManageBtn.text = "No"
            self.stockManageBtn.backgroundColor = UIColor.red
        }
        self.ProductLbl.text = self.inventoryCellVM?.model.term?.title
        self.inventoryImage.layer.cornerRadius = 5
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        let urlString = "https://\(String(describing: self.inventoryCellVM?.model.term?.preview?.media?.url?.dropFirst(2) ?? ""))"
        if let webpURL = URL(string: urlString)  {
            DispatchQueue.main.async {
                self.inventoryImage.sd_setImage(with: webpURL)
            }
        } else {
            self.inventoryImage.image = UIImage(named: "error_placeholder")
        }
    }


}
