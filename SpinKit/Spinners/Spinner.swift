//
//  Spinner.swift
//  SpinKit
//
//  Created by Fernando Moya de Rivas on 16/01/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

protocol SpinnerType: class {
    func startLoading()
}

class Spinner: UIView, SpinnerType {
    func startLoading() { }
}
