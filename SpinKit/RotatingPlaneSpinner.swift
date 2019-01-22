//
//  SquareFlipSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Square plane that rotates first through its Y-axis and then through its X-axis
 */
@IBDesignable
public class RotatingPlaneSpinner: Spinner {
    
    private var squareLayer = CAShapeLayer()
        
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        squareLayer.shouldRasterize = true
        squareLayer.rasterizationScale = UIScreen.main.scale
        layer.addSublayer(squareLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        squareLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        squareLayer.path = UIBezierPath(rect: contentBounds).cgPath
        squareLayer.frame = contentRect
    }
    
    override public func startLoading() {
        super.startLoading()
        
        var zTransform = CATransform3DRotate(CATransform3DIdentity, .pi, 0, 0, 1.0)
        zTransform.m34 = -1.0/200
        
        var yTransform = CATransform3DRotate(CATransform3DIdentity, .pi, 1.0, 0, 0)
        yTransform.m34 = -1.0/200
        
        let rotation = CAKeyframeAnimation(keyPath: "transform")
        rotation.values = [CATransform3DIdentity, yTransform, zTransform]
        rotation.keyTimes = [0, 0.5, 1]
        rotation.duration = 1 / animationSpeed
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [rotation]
        animGroup.repeatCount = .infinity
        animGroup.duration = 1.2 * rotation.duration
        
        squareLayer.add(animGroup, forKey: nil)
    }
    
}
