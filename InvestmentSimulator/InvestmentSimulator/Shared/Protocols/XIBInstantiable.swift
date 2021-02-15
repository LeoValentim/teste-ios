//
//  XIBInstantiable.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import UIKit

protocol XIBInstantiable {
    static func instantiate() -> Self
}

extension XIBInstantiable where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        return Self.init(nibName: className, bundle: Bundle.main)
    }
}
