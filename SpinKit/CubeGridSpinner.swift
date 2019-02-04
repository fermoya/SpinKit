//
//  DecomposeSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 A cube composed by a grid of cubes. The animation splits up this cube and decomposes its parts.
 */
@IBDesignable
public class CubeGridSpinner: Spinner {

    private var cubeLayer = CAShapeLayer()
    private var cubeRowReplicatorLayer = CAReplicatorLayer()
    private var gridReplicatorLayer = CAReplicatorLayer()
    
    private var cubeRect: CGRect {
        return contentBounds.applying(CGAffineTransform(scaleX: 1 / 3, y: 1 / 3))
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        cubeRowReplicatorLayer.instanceCount = 3
        gridReplicatorLayer.instanceCount = 3
        
        cubeRowReplicatorLayer.addSublayer(cubeLayer)
        gridReplicatorLayer.addSublayer(cubeRowReplicatorLayer)
        layer.addSublayer(gridReplicatorLayer)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        cubeLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
        cubeLayer.strokeColor = cubeLayer.fillColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        cubeLayer.path = UIBezierPath(rect: cubeRect).cgPath
        cubeLayer.frame = cubeRect
        cubeRowReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, cubeRect.width, 0, 0)
        gridReplicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, cubeRect.height, 0)
        gridReplicatorLayer.frame = contentRect
    }
    
    override public func startLoading() {
        super.startLoading()
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 0
        scaleAnim.repeatCount = .infinity
        scaleAnim.autoreverses = true
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.83, 0, 0.26, 1.05)
        scaleAnim.duration = 1 / animationSpeed
        
        cubeRowReplicatorLayer.instanceDelay = scaleAnim.duration / Double(cubeRowReplicatorLayer.instanceCount) / 2
        gridReplicatorLayer.instanceDelay = scaleAnim.duration / Double(gridReplicatorLayer.instanceCount) / 2
        
        cubeLayer.add(scaleAnim, forKey: nil)
    }

}
