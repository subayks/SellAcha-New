//
//  Extension + UIViewcontroller.swift
//  Saloon Hub
//
//  Created by Subendran on 29/03/22.
//

import Foundation
import UIKit

var vSpinner : UIView?


extension UIViewController {

    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
      } 
}

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

extension  UIViewController: Loadable {
    

    func showLoadingView() {
          let loadingView = LoadingView()
                view.addSubview(loadingView)
                view.isUserInteractionEnabled = false
                loadingView.translatesAutoresizingMaskIntoConstraints = false
                loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
                loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
                loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
                loadingView.animate()
                
                loadingView.tag = LoaderConstants.loadingViewTag
    }
    
    func hideLoadingView() {
          view.isUserInteractionEnabled = true
                view.alpha = 1
                view.subviews.forEach { subview in
                    if subview.tag == LoaderConstants.loadingViewTag {
                        subview.removeFromSuperview()
                    }
                }
    }
}

final class LoadingView: UIView {
    private let activityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)

        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            backgroundColor = UIColor.darkGray.withAlphaComponent(1)
            layer.cornerRadius = 5
            activityIndicatorView.color = .white
            
            if activityIndicatorView.superview == nil {
                addSubview(activityIndicatorView)
                activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                activityIndicatorView.startAnimating()
            }
        }
        
        public func animate() {
            activityIndicatorView.startAnimating()
        }
    
    }
fileprivate struct LoaderConstants {
    /// an arbitrary tag id for the loading view, so it can be retrieved later without keeping a reference to it
    fileprivate static let loadingViewTag = 1234
}
