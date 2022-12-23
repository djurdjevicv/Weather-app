//
//  Extension.swift
//  Weather app
//
//  Created by praksa on 10.11.22..
//

import Foundation
import UIKit

extension UIView {
    
    func setBackgroundGradient() {
        
        self.layer.sublayers?.forEach({ (layer) in
            if layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        })
        let gradient = CAGradientLayer()
        gradient.name = "gradient"
        let colors = UserDefaults.standard.bool(forKey: Constants.choosenTheme) ? Constants.darkBackgroundColors : Constants.lightBackgroundColors
        gradient.frame = bounds
        gradient.colors = colors
        gradient.locations = [0.0,1.0]
        self.layer.insertSublayer(gradient, at: 0)
    }
}

