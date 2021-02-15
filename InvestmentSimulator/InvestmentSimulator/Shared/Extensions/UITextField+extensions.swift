//
//  UITextField+extensions.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import UIKit

extension UITextField {
    func setCursorLocation(_ location: Int) {
        guard let cursorLocation = position(from: beginningOfDocument, offset: location) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
        }
    }
}
