//
//  DotsSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class DotsSpinner: Spinner {

    private var circleLayer = CAShapeLayer()
    private var circlesReplicatorLayer = CAReplicatorLayer()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        circleLayer.fillColor = UIColor.darkBlue.cgColor
        circlesReplicatorLayer.instanceCount = 3
        
        circlesReplicatorLayer.addSublayer(circleLayer)
        layer.addSublayer(circlesReplicatorLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: bounds.width / 24, y: 0),
                                                       size: CGSize(width: bounds.width / 4,
                                                                    height: bounds.height / 4))).cgPath
        circlesReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, bounds.width / 3, 0, 0)
        circlesReplicatorLayer.frame = CGRect(origin: CGPoint(x: 0,
                                                              y: 3 * bounds.height / 8),
                                              size: CGSize(width: bounds.width, height: bounds.height / 4))
    }
    
    override func startLoading() {
        super.startLoading()
        
        let transform = NSValue(caTransform3D: CATransform3DConcat(CATransform3DScale(CATransform3DIdentity, 0, 0, 1),
                                                                   CATransform3DTranslate(CATransform3DIdentity,
                                                                                          circlesReplicatorLayer.frame.height / 2,
                                                                                          circlesReplicatorLayer.frame.height / 2, 0)))
        
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform")
        scaleAnim.keyTimes = [0, 0.4, 0.8]
        scaleAnim.values = [transform, CATransform3DIdentity, transform]
        scaleAnim.repeatCount = .infinity
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunctions = [.init(name: .easeInEaseOut), .init(name: .easeInEaseOut), .init(name: .easeInEaseOut)]
        scaleAnim.duration = 2
        
        circlesReplicatorLayer.instanceDelay = scaleAnim.duration / Double(circlesReplicatorLayer.instanceCount) / 3
        circleLayer.add(scaleAnim, forKey: nil)
    }

}
