//
//  RadarSpinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 17/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class RadarSpinner: Spinner {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        transform = CGAffineTransform(scaleX: 0, y: 0)
        backgroundColor = UIColor.darkBlue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }

    override func startLoading() {
        super.startLoading()
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .curveEaseOut], animations: { [weak self] in
            self?.alpha = 0
            self?.transform = .identity
        }, completion: nil)
    }

}
