//
//  ViewController.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var spinner: Spinner!
    
    private enum SpinnerType {
        case square
        case circles
        case bars
        case doubleSquare
        case radar
        case bubbles
        case dots
        case fancy
        case decompose
        case classic
        case diamond
    }
    
    @IBAction func didTapSquare(_ sender: UIButton) {
        start(spinner: .square)
    }
    
    @IBAction func didTapCircles(_ sender: UIButton) {
        start(spinner: .circles)
    }
    
    @IBAction func didTapBars(_ sender: UIButton) {
        start(spinner: .bars)
    }
    
    @IBAction func didTapDoubleSquare(_ sender: UIButton) {
        start(spinner: .doubleSquare)
    }
    
    @IBAction func didTapRadar(_ sender: UIButton) {
        start(spinner: .radar)
    }
    
    @IBAction func didTapBubbles(_ sender: UIButton) {
        start(spinner: .bubbles)
    }
    
    @IBAction func didTapDots(_ sender: UIButton) {
        start(spinner: .dots)
    }
    
    @IBAction func didTapFancy(_ sender: UIButton) {
        start(spinner: .fancy)
    }
    
    @IBAction func didTapDecompose(_ sender: UIButton) {
        start(spinner: .decompose)
    }
    
    @IBAction func didTapClassic(_ sender: UIButton) {
        start(spinner: .classic)
    }
    
    @IBAction func didTapDiamond(_ sender: UIButton) {
        start(spinner: .diamond)
    }
    private func start(spinner type: SpinnerType) {
        spinner?.removeFromSuperview()
        switch type {
        case .square:
            spinner = SquareFlipSpinner()
        case .circles:
            spinner = CirclesSpinner()
        case .bars:
            spinner = BarSpinner()
        case .doubleSquare:
            spinner = DoubleSquareSpinner()
        case .radar:
            spinner = RadarSpinner()
        case .bubbles:
            spinner = BubblesSpinner()
        case .dots:
            spinner = DotsSpinner()
        case .fancy:
            spinner = FancySpinner()
        case .decompose:
            spinner = DecomposeSpinner()
        case .classic:
            spinner = ClassicSpinner()
        case .diamond:
            spinner = DiamondSpinner()
        }
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        let centerX = spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerY = spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let width = spinner.widthAnchor.constraint(equalToConstant: 100)
        let height = spinner.heightAnchor.constraint(equalToConstant: 100)
        
        spinner.addConstraints([height, width])
        view.addConstraints([centerX, centerY])
        
        spinner.layoutIfNeeded()
        spinner.startLoading()
    }
}

