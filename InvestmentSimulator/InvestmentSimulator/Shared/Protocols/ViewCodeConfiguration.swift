//
//  ViewCodeConfiguration.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 11/02/21.
//

import Foundation

protocol ViewCodeConfiguration {
    func setupHierarchy()
    func setupConstraint()
    func setupViews()
    func setupAccessability()
}

extension ViewCodeConfiguration {
    func constructViews() {
        setupHierarchy()
        setupConstraint()
        setupViews()
        setupAccessability()
    }
    func setupAccessability() {}
}
