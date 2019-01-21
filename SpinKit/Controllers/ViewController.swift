//
//  ViewController.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController {

    private var spinner: Spinner!
    private var selectedColor: UIColor = UIColor.darkBlue
    
    private enum SpinnerType {
        case rotatingPlane
        case doubleBounce
        case wave
        case wanderingCubes
        case pulse
        case chasingDots
        case threeBounce
        case circle
        case cubeGrid
        case fadingCircle
        case foldingCube
    }
    
    @IBAction func didTapRotatingPlane(_ sender: UIButton) {
        start(spinner: .rotatingPlane)
    }
    
    @IBAction func didTapDoubleBounce(_ sender: UIButton) {
        start(spinner: .doubleBounce)
    }
    
    @IBAction func didTapWave(_ sender: UIButton) {
        start(spinner: .wave)
    }
    
    @IBAction func didTapWanderingCubes(_ sender: UIButton) {
        start(spinner: .wanderingCubes)
    }
    
    @IBAction func didTapPulse(_ sender: UIButton) {
        start(spinner: .pulse)
    }
    
    @IBAction func didTapChasingDots(_ sender: UIButton) {
        start(spinner: .chasingDots)
    }
    
    @IBAction func didTapThreeBounce(_ sender: UIButton) {
        start(spinner: .threeBounce)
    }
    
    @IBAction func didTapCircle(_ sender: UIButton) {
        start(spinner: .circle)
    }
    
    @IBAction func didTapCubeGrid(_ sender: UIButton) {
        start(spinner: .cubeGrid)
    }
    
    @IBAction func didTapFadingCircle(_ sender: UIButton) {
        start(spinner: .fadingCircle)
    }
    
    @IBAction func didTapFoldingCube(_ sender: UIButton) {
        start(spinner: .foldingCube)
    }
    
    private func start(spinner type: SpinnerType) {
        spinner?.removeFromSuperview()
        switch type {
        case .rotatingPlane:
            spinner = RotatingPlaneSpinner(primaryColor: selectedColor)
        case .doubleBounce:
            spinner = DoubleBounceSpinner(primaryColor: selectedColor,
                                          secondaryColor: selectedColor.darken(byPercentage: 0.5))
        case .wave:
            spinner = WaveSpinner(primaryColor: selectedColor)
        case .wanderingCubes:
            spinner = WanderingCubes(primaryColor: selectedColor)
        case .pulse:
            spinner = PulseSpinner(primaryColor: selectedColor)
        case .chasingDots:
            spinner = ChasingDotsSpinner(primaryColor: selectedColor)
        case .threeBounce:
            spinner = ThreeBounceSpinner(primaryColor: selectedColor)
        case .circle:
            spinner = CircleSpinner(primaryColor: selectedColor)
        case .cubeGrid:
            spinner = CubeGridSpinner(primaryColor: selectedColor)
        case .fadingCircle:
            spinner = FadingCircleSpinner(primaryColor: selectedColor)
        case .foldingCube:
            spinner = FoldingCubeSpinner(primaryColor: selectedColor,
                                         secondaryColor: selectedColor.darken(byPercentage: 0.5))
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
    
    @IBAction func didTapColor(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        spinner.primaryColor = color
        selectedColor = color
        
        if let spinner = self.spinner as? DoubleColorSpinner {
            spinner.secondaryColor = color.darken(byPercentage: 0.5)
        }
        
    }
    
}

