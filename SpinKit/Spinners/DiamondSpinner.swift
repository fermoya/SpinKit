//
//  DiamondSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class DiamondSpinner: Spinner {

//    private var diamondLayer = CATextLayer()
    
    private var firstDiamondLayer = CAShapeLayer()
    private var secondDiamondLayer = CAShapeLayer()
    private var rowReplicatorLayer = CAReplicatorLayer()
    private var replicatorLayer = CAReplicatorLayer()

    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        firstDiamondLayer.fillColor = UIColor.lightBlue.cgColor
        firstDiamondLayer.strokeColor = UIColor.lightBlue.cgColor
        secondDiamondLayer.fillColor = UIColor.lightBlue.cgColor
        secondDiamondLayer.strokeColor = UIColor.lightBlue.cgColor
        
        replicatorLayer.instanceCount = 2
        rowReplicatorLayer.instanceCount = 2
        
//        diamondLayer.string = "1"
//        rowReplicatorLayer.instanceGreenOffset = -1
//        replicatorLayer.instanceRedOffset = -1
//        replicatorLayer.instanceGreenOffset = -0.7
//        replicatorLayer.instanceBlueOffset = -0.3
        
        rowReplicatorLayer.addSublayer(secondDiamondLayer)
        rowReplicatorLayer.addSublayer(firstDiamondLayer)
        replicatorLayer.addSublayer(rowReplicatorLayer)
        layer.addSublayer(replicatorLayer)
        transform = CGAffineTransform(rotationAngle: .pi / 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let diamondFrame = bounds.applying(CGAffineTransform(scaleX: 0.5,
                                                             y: 0.5))
        firstDiamondLayer.frame = diamondFrame
        firstDiamondLayer.path = UIBezierPath(rect: diamondFrame).cgPath
        firstDiamondLayer.anchorPoint.x = 1
        
        secondDiamondLayer.frame = diamondFrame
        secondDiamondLayer.path = UIBezierPath(rect: diamondFrame).cgPath
        secondDiamondLayer.anchorPoint.x = 1
        
        replicatorLayer.frame = bounds
        
        rowReplicatorLayer.instanceTransform = CATransform3DConcat(CATransform3DTranslate(CATransform3DIdentity, 0, -2 * diamondFrame.height, 0),
                                                                   CATransform3DRotate(CATransform3DIdentity, .pi / 2, 0, 0, 1))
        replicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, .pi, 0, 0, 1)
    }
    
    override func startLoading() {
        super.startLoading()
        
        let totalDuration: Double = 8
        let delayFactor = 0.4
        let individualDuration = totalDuration / Double(rowReplicatorLayer.instanceCount * replicatorLayer.instanceCount * rowReplicatorLayer.sublayers!.count)
        
        secondDiamondLayer.opacity = 0
        
        let fadeInAnim = CABasicAnimation(keyPath: "opacity")
        fadeInAnim.fromValue = 1
        fadeInAnim.toValue = 0
        fadeInAnim.fillMode = .forwards
        fadeInAnim.duration = individualDuration
        
        let fadeInWrapper = CAAnimationGroup()
        fadeInWrapper.animations = [fadeInAnim]
        fadeInWrapper.duration = totalDuration / 2
        
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
        
        rowReplicatorLayer.instanceDelay = rotateAnim.duration
        replicatorLayer.instanceDelay = 2 * rowReplicatorLayer.instanceDelay
        
        let firstAnimGroup = CAAnimationGroup()
        firstAnimGroup.animations = [fadeInWrapper, rotateAnim, colorAnim]
        firstAnimGroup.duration = (1 + delayFactor) * totalDuration
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
        
        secondAnimGroup.animations = [fadeOutWrapper, rotateAnim]
        secondAnimGroup.duration = (1 + delayFactor) * totalDuration
        secondAnimGroup.beginTime = CACurrentMediaTime() + totalDuration / 2
        secondAnimGroup.repeatCount = .infinity
        
        secondDiamondLayer.add(secondAnimGroup, forKey: nil)
    }
    
}
