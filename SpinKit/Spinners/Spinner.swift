//
//  Spinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

protocol SpinnerType: class {
    func startLoading()
}

class Spinner: UIView, SpinnerType {
    
    var primaryColor: UIColor = UIColor.darkBlue { didSet { setNeedsDisplay() } }

    convenience init(primaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
    }
    
    convenience init(primaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
    }
    
    func startLoading() {
        
    }
    
}

class DoubleColorSpinner: Spinner {
    
    var secondaryColor: UIColor = UIColor.lightBlue { didSet { setNeedsDisplay() } }

    convenience init(primaryColor: UIColor, secondaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    convenience init(primaryColor: UIColor, secondaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}
