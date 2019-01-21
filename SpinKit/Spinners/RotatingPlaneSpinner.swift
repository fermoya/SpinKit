//
//  SquareFlipSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class RotatingPlaneSpinner: Spinner {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        primaryColor.setFill()
        UIRectFill(rect)
    }
    
    override func startLoading() {
        super.startLoading()
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) { [weak self] in
                var identity = CATransform3DIdentity
                identity.m34 = -1.0/200
                self?.layer.transform = CATransform3DRotate(identity, -.pi, 1.0, 0, 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) { [weak self] in
                var identity = CATransform3DIdentity
                identity.m34 = -1.0/200
                self?.layer.transform = CATransform3DRotate(identity, -.pi, 0.0, 0.0, 1.0)
            }

        })
    }
    
}
