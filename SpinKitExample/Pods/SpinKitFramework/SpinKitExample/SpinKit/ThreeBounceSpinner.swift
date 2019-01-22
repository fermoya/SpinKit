//
//  DotsSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Three bouncing dots placed horizontally.
 */
@IBDesignable
public class ThreeBounceSpinner: Spinner {

    private var circleLayer = CAShapeLayer()
    private var circlesReplicatorLayer = CAReplicatorLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        circlesReplicatorLayer.instanceCount = 3
        circlesReplicatorLayer.addSublayer(circleLayer)
        layer.addSublayer(circlesReplicatorLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        circleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero,
                                                       size: CGSize(width: contentSize.width / 4,
                                                                    height: contentSize.height / 4))).cgPath
        circleLayer.frame = circleLayer.path!.boundingBox.applying(CGAffineTransform(translationX: contentSize.width / 32,
                                                                                     y: 3 / 8 * contentSize.height))
        circlesReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, contentSize.width / 3, 0, 0)
        circlesReplicatorLayer.frame = contentRect
    }
    
    override public func startLoading() {
        super.startLoading()
        
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.keyTimes = [0, 0.4, 0.8]
        scaleAnim.values = [0, 1, 0]
        scaleAnim.repeatCount = .infinity
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunctions = [.init(name: .easeInEaseOut), .init(name: .easeInEaseOut), .init(name: .easeInEaseOut)]
        scaleAnim.duration = 2 / animationSpeed
        
        circlesReplicatorLayer.instanceDelay = scaleAnim.duration / Double(circlesReplicatorLayer.instanceCount) / 3
        circleLayer.add(scaleAnim, forKey: nil)
    }

}
