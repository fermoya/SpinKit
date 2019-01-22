//
//  DoubleSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Two rotating cubes following a square path.
 */
@IBDesignable
public class WanderingCubesSpinner: Spinner {
    
    private var leftSquareLayer = CAShapeLayer()
    private var rightSquareLayer = CAShapeLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(leftSquareLayer)
        layer.addSublayer(rightSquareLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        leftSquareLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
        rightSquareLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(rect: CGRect(origin: .zero,
                                             size: CGSize(width: contentSize.width / 4, height: contentSize.height / 4)))
        leftSquareLayer.path = path.cgPath
        leftSquareLayer.frame = CGRect(origin: contentOrigin,
                                       size: CGSize(width: contentSize.width / 4,
                                                    height: contentSize.height / 4))
        
        rightSquareLayer.path = path.cgPath
        rightSquareLayer.frame = leftSquareLayer.frame.applying(CGAffineTransform(translationX: 6 * contentSize.width / 8, y: 6 * contentSize.width / 8))
    }
    
    override public func startLoading() {
        super.startLoading()
        
        // COMMON
        let rotateAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnim.values = [0, Double.pi / 2, Double.pi, 3 * Double.pi / 2, 2 * Double.pi]
        rotateAnim.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        rotateAnim.timingFunctions = [.init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut), .init(name: .easeOut)]
        
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [1, 0.5, 1, 0.5, 1]
        scaleAnim.keyTimes = rotateAnim.keyTimes
        scaleAnim.timingFunctions = rotateAnim.timingFunctions
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = 2.2 / animationSpeed
        animGroup.repeatCount = .infinity
        
        // LEFT
        let translateLeftAnim = CAKeyframeAnimation(keyPath: "position")
        translateLeftAnim.values = [NSValue(cgPoint: leftSquareLayer.position),
                                NSValue(cgPoint: CGPoint(x: rightSquareLayer.position.x, y: leftSquareLayer.position.y)),
                                NSValue(cgPoint: rightSquareLayer.position),
                                NSValue(cgPoint: CGPoint(x: leftSquareLayer.position.x, y: rightSquareLayer.position.y)),
                                NSValue(cgPoint: leftSquareLayer.position)]
        translateLeftAnim.keyTimes = rotateAnim.keyTimes
        translateLeftAnim.timingFunctions = rotateAnim.timingFunctions
        
        animGroup.animations = [translateLeftAnim, rotateAnim, scaleAnim]
        leftSquareLayer.add(animGroup, forKey: nil)
        
        // RIGHT
        let translateRightAnim = CAKeyframeAnimation(keyPath: "position")
        translateRightAnim.values = [NSValue(cgPoint: rightSquareLayer.position),
                                     NSValue(cgPoint: CGPoint(x: leftSquareLayer.position.x, y: rightSquareLayer.position.y)),
                                     NSValue(cgPoint: leftSquareLayer.position),
                                     NSValue(cgPoint: CGPoint(x: rightSquareLayer.position.x, y: leftSquareLayer.position.y)),
                                     NSValue(cgPoint: rightSquareLayer.position)]
        translateRightAnim.keyTimes = rotateAnim.keyTimes
        translateRightAnim.timingFunctions = rotateAnim.timingFunctions
        
        animGroup.animations = [translateRightAnim, rotateAnim, scaleAnim]
        rightSquareLayer.add(animGroup, forKey: nil)
    }
    
}
