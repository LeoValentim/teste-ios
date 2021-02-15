//
//  CustomButton.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        setTitleColor(.white, for: .normal)
        backgroundColor = isEnabled ? #colorLiteral(red: 0, green: 0.7843222022, blue: 0.7007431388, alpha: 1) : #colorLiteral(red: 0.7631228566, green: 0.7931808829, blue: 0.7882085443, alpha: 1)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2
    }
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? #colorLiteral(red: 0, green: 0.7843222022, blue: 0.7007431388, alpha: 1) : #colorLiteral(red: 0.7631228566, green: 0.7931808829, blue: 0.7882085443, alpha: 1)
        }
    }
}
