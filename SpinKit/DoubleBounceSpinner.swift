//
//  CirclesSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Two circles with the same center, one contained within the other one. They bounce when animated.
 */
@IBDesignable
public class DoubleBounceSpinner: DoubleColorSpinner {

    private var outterCircleLayer = CAShapeLayer()
    private var innerCircleLayer = CAShapeLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()

        layer.addSublayer(outterCircleLayer)
        layer.addSublayer(innerCircleLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        outterCircleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
        innerCircleLayer.fillColor = isTranslucent ? secondaryColor.cgColor : UIColor.lightGray.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        outterCircleLayer.path = UIBezierPath(ovalIn: contentBounds).cgPath
        outterCircleLayer.frame = contentRect

        innerCircleLayer.path = UIBezierPath(ovalIn: contentBounds.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))).cgPath
        innerCircleLayer.frame = CGRect(x: contentSize.width / 4 + contentOrigin.x,
                                        y: contentSize.height / 4 + contentOrigin.y,
                                        width: contentSize.width / 2,
                                        height: contentSize.height / 2)
    }
    
    override public func startLoading() {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = 1
        anim.toValue =  0.5
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.duration = 0.4 / animationSpeed
        anim.autoreverses = true
        anim.repeatCount = .infinity
        
        outterCircleLayer.add(anim, forKey: nil)
        
        anim.fromValue =  0
        anim.toValue =  1
        
        innerCircleLayer.add(anim, forKey: nil)
    }

}
