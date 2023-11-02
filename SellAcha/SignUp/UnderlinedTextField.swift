//
//  UnderlinedTextField.swift
//  UnderlinedTextField
//
//  Created by Duncan Champney on 12/18/21.
//

import UIKit

/// This is a custom subclass of UITextField that adds a 1-point colored underline under the text field using a CALayer.
/// It implments the `layoutSubviews()` method to reposition the underline layer if the text field is moved or resized.
class UnderlinedTextField: UITextField {

    /// Change this color to change the color used for the underline
    public var underlineColor = UIColor.lightGray {
        didSet {
            underlineLayer.backgroundColor = underlineColor.cgColor
        }
    }

    private let underlineLayer = CALayer()

    /// Size the underline layer and position it as a one point line under the text field.
    func setupUnderlineLayer() {
        var frame = self.bounds
        frame.origin.y = frame.size.height - 1
        frame.size.height = 1
        

        underlineLayer.frame = frame
        underlineLayer.backgroundColor = underlineColor.cgColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // In `init?(coder:)` Add our underlineLayer as a sublayer of the view's main layer
        self.layer.addSublayer(underlineLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        // in `init(frame:)` Add our underlineLayer as a sublayer of the view's main layer
        self.layer.addSublayer(underlineLayer)
    }

    // Any time we are asked to update our subviews,
    // adjust the size and placement of the underline layer too
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUnderlineLayer()
    }
}
