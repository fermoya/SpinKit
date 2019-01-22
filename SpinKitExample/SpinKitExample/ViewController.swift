//
//  ViewController.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import SpinKit
import ChameleonFramework

class ViewController: UIViewController {
    
    private var spinner: Spinner!
    private var selectedColor: UIColor = UIColor.blue
    
    @IBOutlet weak var lastStackView: UIStackView!
    @IBOutlet weak var isTranslucentSwitch: UISwitch!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    
    private var availableSpace: CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: (isTranslucentSwitch.frame.origin.y) - (lastStackView.frame.origin.y + lastStackView.frame.height))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        widthSlider.maximumValue = Float(availableSpace.width)
        widthSlider.value = widthSlider.maximumValue / 2
        widthSlider.minimumValue = 0
        
        heightSlider.maximumValue = Float(availableSpace.height)
        heightSlider.value = heightSlider.maximumValue / 2
        heightSlider.minimumValue = 0
        
        speedSlider.maximumValue = 4
        speedSlider.value = 1
        speedSlider.minimumValue = 0.25
        
        start(spinner: .rotatingPlane)
    }
    
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
    
    @IBAction func speedSliderDidChange(_ sender: UISlider) {
        spinner.animationSpeed = Double(sender.value)
    }
    
    @IBAction func widthSliderDidChange(_ sender: UISlider) {
        spinner.constraints.first { $0.identifier == "width" }?.constant = CGFloat(sender.value)
    }
    
    @IBAction func heightSliderDidChange(_ sender: UISlider) {
        spinner.constraints.first { $0.identifier == "height" }?.constant = CGFloat(sender.value)
    }
    
    @IBAction func switchDidTap(_ sender: UISwitch) {
        spinner.isTranslucent = sender.isOn
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
            spinner = WanderingCubesSpinner(primaryColor: selectedColor)
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
        
        let top = spinner.topAnchor.constraint(equalTo: lastStackView.bottomAnchor)
        let centerX = spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = spinner.widthAnchor.constraint(equalToConstant: CGFloat(widthSlider.value))
        width.identifier = "width"
        let height = spinner.heightAnchor.constraint(equalToConstant: CGFloat(heightSlider.value))
        height.identifier = "height"
        
        spinner.addConstraints([height, width])
        view.addConstraints([top, centerX])
        
        spinner.animationSpeed = Double(speedSlider.value)
        spinner.isTranslucent = isTranslucentSwitch.isOn
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

