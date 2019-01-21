//
//  BubblesSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class BubblesSpinner: Spinner {

    private var leftCircleLayer = CAShapeLayer()
    private var rightCircleLayer = CAShapeLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        leftCircleLayer.fillColor = UIColor.darkBlue.cgColor
        rightCircleLayer.fillColor = UIColor.darkBlue.cgColor
        
        layer.addSublayer(rightCircleLayer)
        layer.addSublayer(leftCircleLayer)
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let circleSize = CGSize(width: bounds.width / 2, height: bounds.height / 2)
        leftCircleLayer.frame = CGRect(origin: .zero,
                                       size: circleSize)
        leftCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
        
        rightCircleLayer.frame = CGRect(origin: .zero,
                                        size: circleSize)
        rightCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
    }
    
    override func startLoading() {
        super.startLoading()

        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.fromValue = CATransform3DScale(CATransform3DIdentity, 0, 0, 1)
        scaleAnimation.toValue = CATransform3DIdentity
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.duration = 1.1
        scaleAnimation.fillMode = .backwards
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: bounds.width / 4 + leftCircleLayer.frame.size.width / 16,
                                                                             y: bounds.height / 4 + leftCircleLayer.frame.size.height / 16),
                                                             size: CGSize(width: bounds.width / 2, height: bounds.height / 2))).cgPath
        positionAnimation.repeatCount = .infinity
        positionAnimation.fillMode = .backwards
        positionAnimation.duration = 2
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
