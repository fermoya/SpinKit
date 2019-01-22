//
//  RadarSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Spinner that imitates a pulse in the water.
 */
@IBDesignable
public class PulseSpinner: Spinner {
    
    private var pulseLayer = CAShapeLayer()
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        pulseLayer.masksToBounds = true
        layer.addSublayer(pulseLayer)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        pulseLayer.frame = contentRect
        pulseLayer.path = UIBezierPath(rect: contentBounds).cgPath
        pulseLayer.cornerRadius = min(contentSize.width, contentSize.height) / 2
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        pulseLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
    }

    override public func startLoading() {
        super.startLoading()
        
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = 0
        opacityAnim.duration = 1 / animationSpeed
        opacityAnim.fillMode = .forwards
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 0
        scaleAnim.toValue = 1
        scaleAnim.duration = 1 / animationSpeed
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [opacityAnim, scaleAnim]
        animGroup.repeatCount = .infinity
        animGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animGroup.duration = 1.2 / animationSpeed
        
        pulseLayer.add(animGroup, forKey: nil)
    }

}
