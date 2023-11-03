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
        //        let url = self.vm?.model.preview?.media?.url?.dropFirst(2)
        //        self.productImage.loadImageUsingURL("\(String(describing: url ?? ""))")
        self.lastUpdate.text = self.vm?.model.formateDate
        
        if self.vm?.model.isSelected  == true {
            self.checkBoxImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            self.checkBoxImage.image = UIImage(systemName: "")
        }
        
        if self.vm?.model.status == 1 {
            self.fulfilmentStatus.backgroundColor = .green
            self.fulfilmentStatus.setTitle("Active", for: .normal)
        } else  {
            self.fulfilmentStatus.backgroundColor = .orange
            self.fulfilmentStatus.setTitle("In-Active", for: .normal)
        }
//        let onlineFileUrl = URL(string: String(self.vm?.model.preview?.media?.url?.dropFirst(2) ?? ""))
//             //load from project directory
//                let loaclFileUrl = Bundle.main.url(forResource: "2", withExtension: "webp")
//            DispatchQueue.main.async {
//                self.productImage.sd_setImage(with: loaclFileUrl)
//            }
        
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        if let webpURL = URL(string: (String(self.vm?.model.preview?.media?.url?.dropFirst(2) ?? "")))  {
            DispatchQueue.main.async {
                self.productImage.sd_setImage(with: webpURL)
            }
        }
//        SDWebImageManager.shared().loadImage(with: self.vm?.model.preview?.media?.url?.dropFirst(2), options: .highPriority, progress: nil, completed: {(resultSet) in
//            productImage.image = resultSet.0
//
//        })
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




