//
//  CirclesSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class DoubleBounceSpinner: DoubleColorSpinner {

    private var outterCircleLayer = CAShapeLayer()
    private var innerCircleLayer = CAShapeLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()

        layer.addSublayer(outterCircleLayer)
        layer.addSublayer(innerCircleLayer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        outterCircleLayer.fillColor = primaryColor.cgColor
        innerCircleLayer.fillColor = secondaryColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        outterCircleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        outterCircleLayer.frame = bounds

        innerCircleLayer.path = UIBezierPath(ovalIn: bounds.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))).cgPath
        innerCircleLayer.frame = CGRect(x: bounds.width / 4,
                                        y: bounds.height / 4,
                                        width: bounds.width / 2,
                                        height: bounds.height / 2)
    }
    
    override func startLoading() {
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        anim.toValue =  NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 1))
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.duration = 0.4
        anim.autoreverses = true
        anim.repeatCount = .infinity
        
        outterCircleLayer.add(anim, forKey: nil)
        
        anim.fromValue =  NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0, 0, 1))
        anim.toValue =  NSValue(caTransform3D: CATransform3DIdentity)
        
        innerCircleLayer.add(anim, forKey: nil)
    }

}
