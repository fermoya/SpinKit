//
//  DiamondSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class DiamondSpinner: Spinner {
    
    private var firstDiamondLayer = CAShapeLayer()
    private var secondDiamondLayer = CAShapeLayer()
    private var firstReplicatorLayer = CAReplicatorLayer()
    private var secondReplicatorLayer = CAReplicatorLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        firstDiamondLayer.fillColor = UIColor.lightBlue.cgColor
        firstDiamondLayer.strokeColor = UIColor.lightBlue.cgColor
        secondDiamondLayer.fillColor = UIColor.lightBlue.cgColor
        secondDiamondLayer.strokeColor = UIColor.lightBlue.cgColor
        
//        diamondLayer.string = "1"
//        rowReplicatorLayer.instanceGreenOffset = -1
//        replicatorLayer.instanceRedOffset = -1
//        replicatorLayer.instanceGreenOffset = -0.7
//        replicatorLayer.instanceBlueOffset = -0.3
        
        firstReplicatorLayer.instanceCount = 4
        firstReplicatorLayer.addSublayer(firstDiamondLayer)
        
        secondReplicatorLayer.instanceCount = 3
        secondReplicatorLayer.addSublayer(secondDiamondLayer)
        
        layer.addSublayer(firstReplicatorLayer)
        layer.addSublayer(secondReplicatorLayer)
        
        transform = CGAffineTransform(rotationAngle: .pi / 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let diamondFrame = bounds.applying(CGAffineTransform(scaleX: 0.5,
                                                             y: 0.5))
        firstDiamondLayer.frame = diamondFrame
        firstDiamondLayer.path = UIBezierPath(rect: diamondFrame).cgPath
        firstDiamondLayer.anchorPoint.x = 1
        
        secondDiamondLayer.frame = firstDiamondLayer.frame
        secondDiamondLayer.path = firstDiamondLayer.path
        secondDiamondLayer.anchorPoint.x = firstDiamondLayer.anchorPoint.x
        
        firstReplicatorLayer.frame = bounds
        secondReplicatorLayer.frame = bounds

        firstReplicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, .pi / 2, 0, 0, 1)
        secondReplicatorLayer.instanceTransform = firstReplicatorLayer.instanceTransform
    }
    
    override func startLoading() {
        super.startLoading()
        
        let totalDuration: Double = 8
        let delayFactor = 0.2

        let effectiveDuration = (1 - delayFactor) * totalDuration
        let individualDuration = effectiveDuration / Double(2 * firstReplicatorLayer.instanceCount)
        
        secondDiamondLayer.opacity = 0
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.fillMode = .forwards
        opacity.duration = individualDuration
        
        let fadeInWrapper = CAAnimationGroup()
        fadeInWrapper.animations = [opacity]
        fadeInWrapper.duration = effectiveDuration / 2
        
        let colorAnim = CAKeyframeAnimation(keyPath: "fillColor")
        colorAnim.values = [UIColor.lightBlue.cgColor, UIColor.darkBlue.cgColor, UIColor.lightBlue.cgColor]
        colorAnim.keyTimes = [0, 0.5, 1]
        colorAnim.duration = individualDuration
        
        var transform = CATransform3DRotate(CATransform3DIdentity, CGFloat.pi, 0, 1, 0)
        transform.m34 = -1 / 200
        
        let rotateAnim = CABasicAnimation(keyPath: "transform")
        rotateAnim.fromValue = CATransform3DIdentity
        rotateAnim.toValue = transform
        rotateAnim.timingFunction = CAMediaTimingFunction(name: .linear)
        rotateAnim.duration = individualDuration
        
        firstReplicatorLayer.instanceDelay = individualDuration
        secondReplicatorLayer.instanceDelay = individualDuration
        
        let firstAnimGroup = CAAnimationGroup()
        firstAnimGroup.animations = [fadeInWrapper, rotateAnim, colorAnim]
        firstAnimGroup.duration = totalDuration
        firstAnimGroup.repeatCount = .infinity
        
        firstDiamondLayer.add(firstAnimGroup, forKey: nil)
        
        let secondAnimGroup = CAAnimationGroup()

        let fadeOutAnim = CABasicAnimation(keyPath: "opacity")
        fadeOutAnim.fromValue = 0
        fadeOutAnim.toValue = 1
        fadeOutAnim.fillMode = .forwards
        fadeOutAnim.duration = individualDuration
        
        let fadeOutWrapper = CAAnimationGroup()
        fadeOutWrapper.animations = [fadeOutAnim]
        fadeOutWrapper.duration = fadeInWrapper.duration
        
        secondAnimGroup.animations = [fadeOutWrapper, rotateAnim, colorAnim]
        secondAnimGroup.duration = totalDuration
        secondAnimGroup.beginTime = CACurrentMediaTime() + effectiveDuration / 2
        secondAnimGroup.repeatCount = .infinity
        
        secondDiamondLayer.add(secondAnimGroup, forKey: nil)
    }
    
}
