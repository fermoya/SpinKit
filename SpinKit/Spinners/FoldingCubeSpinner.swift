//
//  DiamondSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class FoldingCubeSpinner: DoubleColorSpinner {
    
    private var firstDiamondLayer = CAShapeLayer()
    private var secondDiamondLayer = CAShapeLayer()
    private var firstReplicatorLayer = CAReplicatorLayer()
    private var secondReplicatorLayer = CAReplicatorLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        firstDiamondLayer.fillColor = primaryColor.cgColor
        firstDiamondLayer.strokeColor = primaryColor.cgColor
        secondDiamondLayer.fillColor = primaryColor.cgColor
        secondDiamondLayer.strokeColor = primaryColor.cgColor
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
        
        let totalDuration: Double = 4
        let delayFactor = 0.2

        let effectiveDuration = (1 - delayFactor) * totalDuration
        let individualDuration = effectiveDuration / Double(2 * firstReplicatorLayer.instanceCount)
        
        secondDiamondLayer.opacity = 0
        
        let fadeOutAnim = CABasicAnimation(keyPath: "opacity")
        fadeOutAnim.fromValue = 1
        fadeOutAnim.toValue = 0
        fadeOutAnim.fillMode = .forwards
        fadeOutAnim.duration = individualDuration
        
        let fadeOutWrapper = CAAnimationGroup()
        fadeOutWrapper.animations = [fadeOutAnim]
        fadeOutWrapper.duration = effectiveDuration / 2
        
        let colorAnim = CAKeyframeAnimation(keyPath: "fillColor")
        colorAnim.values = [primaryColor.cgColor, UIColor.darkBlue.cgColor, secondaryColor.cgColor]
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
        firstAnimGroup.animations = [fadeOutWrapper, rotateAnim, colorAnim]
        firstAnimGroup.duration = totalDuration
        firstAnimGroup.repeatCount = .infinity
        
        firstDiamondLayer.add(firstAnimGroup, forKey: nil)
        
        let secondAnimGroup = CAAnimationGroup()

        let fadeInAnim = CABasicAnimation(keyPath: "opacity")
        fadeInAnim.fromValue = 0
        fadeInAnim.toValue = 1
        fadeInAnim.fillMode = .forwards
        fadeInAnim.duration = individualDuration
        
        let fadeInWrapper = CAAnimationGroup()
        fadeInWrapper.animations = [fadeInAnim]
        fadeInWrapper.duration = fadeOutWrapper.duration
        
        secondAnimGroup.animations = [fadeInWrapper, rotateAnim, colorAnim]
        secondAnimGroup.duration = totalDuration
        secondAnimGroup.beginTime = CACurrentMediaTime() + effectiveDuration / 2
        secondAnimGroup.repeatCount = .infinity
        
        secondDiamondLayer.add(secondAnimGroup, forKey: nil)
    }
    
}
