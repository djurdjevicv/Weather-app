//
//  UINavigationBar+Extension.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import Foundation
import UIKit

extension UINavigationBar {

    func styleNavigationBar(){
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        tintColor = .white
        titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
