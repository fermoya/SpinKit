//
//  Spinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Spinner protocol that exposes its interface
 */
public protocol SpinnerType: class {
    /// Starts the spinner animation
    func startLoading()
    
    /// Primary color of the spinner
    var primaryColor: UIColor { get set }
    
    /// Flag that indicates if the view is opaque or translucent. It modifies the way in which the primary color is applied.
    var isTranslucent: Bool { get set }
    
    /// Insets of the spinner
    var contentInsets: UIEdgeInsets { get set }
    
    /// Speed of the animation
    var animationSpeed: Double { get set }
}

/**
 Spinner base class. It's a view that exposes the spinner type interface
*/
@IBDesignable
public class Spinner: UIView, SpinnerType {
    
    @IBInspectable public var primaryColor: UIColor = UIColor.darkBlue { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var isTranslucent: Bool = true { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) { didSet { setNeedsLayout() } }
    
    public var animationSpeed: Double = 1
    
    var contentSize: CGSize {
        let size = min(bounds.width - (contentInsets.left + contentInsets.right),
                       bounds.height - (contentInsets.top + contentInsets.bottom))
        return CGSize(width: size,
                      height: size)
    }
    
    var contentOrigin: CGPoint {
        return CGPoint(x: (bounds.width - contentSize.width) / 2,
                       y: (bounds.height - contentSize.height) / 2)
    }
    
    var contentRect: CGRect {
        return CGRect(origin: contentOrigin, size: contentSize)
    }
    
    var contentBounds: CGRect {
        return CGRect(origin: .zero, size: contentSize)
    }
    
    /**
     Initializes a new Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
    */
    public convenience init(primaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
    }
    
    /**
     Initializes a new Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isTranslucent {
            isOpaque = !isTranslucent
        } else {
            primaryColor.setFill()
            UIRectFill(rect)
        }
    }
    
    public func startLoading() {
        layoutIfNeeded()
    }
    
}

/**
 Extended spinner. It uses two different colors.
 */
public class DoubleColorSpinner: Spinner {
    
    /// Secondary color of the spinner
    public var secondaryColor: UIColor = UIColor.lightBlue { didSet { setNeedsDisplay() } }

    /**
     Initializes a new extended Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter secondaryColor:    Secondary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, secondaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    /**
     Initializes a new extended Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter secondaryColor:    Secondary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, secondaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

extension UIColor {
    static var lightBlue: UIColor { return UIColor(red: 100 / 255, green: 181 / 255, blue: 246 / 255, alpha: 1) }
    static var darkBlue: UIColor { return UIColor(red: 30 / 255, green: 136 / 255, blue: 229 / 255, alpha: 1) }
}
