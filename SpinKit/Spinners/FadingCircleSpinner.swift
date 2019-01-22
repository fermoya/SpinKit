//
//  ClassicSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

/**
 Spinner composed by fading dots placed in a circle path.
 */
public class FadingCircleSpinner: CircleSpinner {

    override public func startLoading() {
        layoutIfNeeded()
        
        let scaleAnim = CABasicAnimation(keyPath: "opacity")
        scaleAnim.fromValue = 0
        scaleAnim.toValue = 1
        scaleAnim.repeatCount = .infinity
        scaleAnim.autoreverses = true
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunction = .init(name: .easeOut)
        scaleAnim.duration = 0.7
        
        circleLayers.enumerated().forEach {
            scaleAnim.beginTime = CACurrentMediaTime() + 2 * Double($0.offset) * scaleAnim.duration / Double(circleLayers.count)
            $0.element.add(scaleAnim, forKey: nil)
        }
    }

}
