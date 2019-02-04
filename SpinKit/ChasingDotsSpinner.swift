//
//  BubblesSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Two circle chasing each other in a circle path while growing and shrinking.
 */
@IBDesignable
public class ChasingDotsSpinner: Spinner {

    private var leftCircleLayer = CAShapeLayer()
    private var rightCircleLayer = CAShapeLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(rightCircleLayer)
        layer.addSublayer(leftCircleLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        leftCircleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
        rightCircleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let circleSize = CGSize(width: contentSize.width / 2, height: contentSize.height / 2)
        leftCircleLayer.frame = CGRect(origin: contentOrigin,
                                       size: circleSize)
        leftCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
        
        rightCircleLayer.frame = CGRect(origin: contentOrigin,
                                        size: circleSize)
        rightCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
    }
    
    override public func startLoading() {
        super.startLoading()

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.duration = 1.1 / animationSpeed
        scaleAnimation.fillMode = .backwards
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: contentSize.width / 4 + leftCircleLayer.frame.size.width / 16 + contentOrigin.x,
                                                                             y: contentSize.height / 4 + leftCircleLayer.frame.size.height / 16 + contentOrigin.y),
                                                             size: CGSize(width: contentSize.width / 2, height: contentSize.height / 2))).cgPath
        positionAnimation.repeatCount = .infinity
        positionAnimation.fillMode = .backwards
        positionAnimation.duration = 2 / animationSpeed
        positionAnimation.calculationMode = .paced
        
        leftCircleLayer.add(positionAnimation, forKey: nil)
        leftCircleLayer.add(scaleAnimation, forKey: nil)
        
        positionAnimation.beginTime = CACurrentMediaTime() + 0.3
        scaleAnimation.toValue = CATransform3DScale(CATransform3DIdentity, 0, 0, 1)
        scaleAnimation.fromValue = CATransform3DIdentity
        
        rightCircleLayer.add(positionAnimation, forKey: nil)
        rightCircleLayer.add(scaleAnimation, forKey: nil)
    }

}
