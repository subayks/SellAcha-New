//
//  ChatNowVC.swift
//  SellAcha
//
//  Created by Subaykala on 05/11/23.
//

import UIKit

class ChatNowVC: UIViewController {

    @IBOutlet weak var chatNowLabelButton: UIButton!
    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var buttonChatNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.imagePerson.layer.cornerRadius = self.imagePerson.frame.height/2
        self.buttonChatNow.layer.cornerRadius = self.buttonChatNow.frame.height/2
    }
    
    @IBAction func actionChatNow(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "You are leaving application, are you sure?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            if let url = URL(string: "https://sellacha.com/mysp.html"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
