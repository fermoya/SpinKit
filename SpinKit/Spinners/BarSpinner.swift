//
//  BarSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class BarSpinner: Spinner {
    
    private var barLayer = CAShapeLayer()
    private var barsReplicantLayer = CAReplicatorLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        barLayer.fillColor = UIColor.darkBlue.cgColor
        
        barsReplicantLayer.addSublayer(barLayer)
        layer.addSublayer(barsReplicantLayer)
        
        barsReplicantLayer.instanceCount = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let barRect = CGRect(x: 0, y: 0, width: bounds.width / 6, height: bounds.height)
        barLayer.path = UIBezierPath(rect: barRect).cgPath
        barsReplicantLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(barsReplicantLayer.instanceCount) * barRect.width / 4, 0, 0)
        barsReplicantLayer.frame = barRect.applying(CGAffineTransform(scaleX: 6, y: 1))
    }
    
    override func startLoading() {
        super.startLoading()
        
        let anim = CAKeyframeAnimation(keyPath: "transform")
        let transform = CATransform3DConcat(CATransform3DScale(CATransform3DIdentity, 1, 0.5, 0),
                                            CATransform3DTranslate(CATransform3DIdentity, 0, bounds.height / 4, 0))
        anim.values = [transform, CATransform3DIdentity]
        anim.keyTimes = [0.5, 1]
        anim.duration = 0.5
        anim.autoreverses = true
        anim.repeatCount = .infinity
        anim.fillMode = CAMediaTimingFillMode.backwards
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        barLayer.add(anim, forKey: nil)
        
        barsReplicantLayer.instanceDelay = anim.duration / CFTimeInterval(barsReplicantLayer.instanceCount)
    }
    
}
