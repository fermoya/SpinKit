//
//  BarSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Five vertical bars moving imitating a wave motion.
 */
@IBDesignable
public class WaveSpinner: Spinner {
    
    private var barLayer = CAShapeLayer()
    private var barsReplicantLayer = CAReplicatorLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        barsReplicantLayer.addSublayer(barLayer)
        layer.addSublayer(barsReplicantLayer)
        
        barsReplicantLayer.instanceCount = 5
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        barLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let barRect = CGRect(origin: .zero,
                             size: CGSize(width: contentSize.width / 6,
                                          height: contentSize.height))
        barLayer.path = UIBezierPath(rect: barRect).cgPath
        barLayer.bounds = barLayer.path!.boundingBox
        barLayer.position = CGPoint(x: barRect.width / 2,
                                    y: contentBounds.midY)
        
        barsReplicantLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(barsReplicantLayer.instanceCount) * barRect.width / 4, 0, 0)
        barsReplicantLayer.frame = contentRect
    }
    
    override public func startLoading() {
        super.startLoading()
        
        let anim = CAKeyframeAnimation(keyPath: "transform.scale.y")
        anim.values = [0.4, 1]
        anim.keyTimes = [0.5, 1]
        anim.duration = 0.5 / animationSpeed
        anim.autoreverses = true
        anim.repeatCount = .infinity
        anim.fillMode = CAMediaTimingFillMode.backwards
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        barLayer.add(anim, forKey: nil)
        
        barsReplicantLayer.instanceDelay = anim.duration / CFTimeInterval(barsReplicantLayer.instanceCount)
    }
    
}
