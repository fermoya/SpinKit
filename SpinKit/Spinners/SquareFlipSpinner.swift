//
//  SquareFlipSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class SquareFlipSpinner: Spinner {
    
    override func startLoading() {
        super.startLoading()
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        backgroundColor = UIColor.lightBlue
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: { [weak self] in
                self?.backgroundColor = UIColor.darkBlue
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) { [weak self] in
                var identity = CATransform3DIdentity
                identity.m34 = -1.0/1000
                self?.layer.transform = CATransform3DRotate(identity, -.pi, 1.0, 0, 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: { [weak self] in
                self?.backgroundColor = UIColor.lightBlue
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: { [weak self] in
                self?.backgroundColor = UIColor.darkBlue
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) { [weak self] in
                var identity = CATransform3DIdentity
                identity.m34 = -1.0/1000
                self?.layer.transform = CATransform3DRotate(identity, -.pi, 0.0, 0.0, 1.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: { [weak self] in
                self?.backgroundColor = UIColor.lightBlue
            })
        })
    }
    
}
