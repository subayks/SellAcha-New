//
//  BagTableViewCell.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit
import SDWebImageWebPCoder
class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}


class BagTableViewCell: UITableViewCell {

    @IBOutlet weak var totalStatusValue: UILabel!
    @IBOutlet weak var lastUpdateValue: UILabel!
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    @IBOutlet weak var fulfilmentStatus: UIButton!
    @IBOutlet weak var csutomerNameLabel: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var totalSales: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var vm: BagTableViewCellVM? {
        didSet {
            self.setupValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.checkBoxImage.layer.borderWidth = 0.5
        self.checkBoxImage.layer.borderColor = UIColor.gray.cgColor
        self.fulfilmentStatus.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupValues() {
        self.csutomerNameLabel.text = self.vm?.model.title
        self.lastUpdateValue.text = self.vm?.model.formateDate
        
        if self.vm?.model.isSelected  == true {
            self.checkBoxImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            self.checkBoxImage.image = UIImage(systemName: "")
        }
        
        if self.vm?.model.status == 1 {
            self.fulfilmentStatus.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
            self.fulfilmentStatus.setTitle("Active", for: .normal)
        } else  {
            self.fulfilmentStatus.backgroundColor =  UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 255/255)
            self.fulfilmentStatus.setTitle("In-Active", for: .normal)
        }
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

extension UIImageView {
    func loadImageUsingURL(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image: UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            } else {
                setImage(image: nil)
            }
        }
    }
}





