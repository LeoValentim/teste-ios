//
//  SimulationListRowView.swift
//  InvestmentSimulator
//
//  Created by c83155a on 13/02/21.
//

import UIKit
import Cartography

class SimulationListRowView: UIView {
    // MARK: UI components
    private lazy var titleLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var valueLabel: UILabel = { return UILabel(frame: .zero) }()
    // MARK: Initializers
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constructViews()
    }
}

extension SimulationListRowView: ViewCodeConfiguration {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(valueLabel)
    }
    func setupConstraint() {
        Cartography.constrain(titleLabel, self) { title, view in
            title.top == view.top
            title.left == view.left
            title.bottom == view.bottom
        }
        Cartography.constrain(valueLabel, self) { value, view in
            value.top == view.top
            value.right == view.right
            value.bottom == view.bottom
        }
        Cartography.constrain(titleLabel, valueLabel) { title, value in
            title.right == value.left + 8
        }
    }
    func setupViews() {
        // Title
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor.Compatible.secondaryLabel
        // Value
        valueLabel.textAlignment = .right
        valueLabel.adjustsFontForContentSizeCategory = true
        valueLabel.font = .preferredFont(forTextStyle: .body)
        valueLabel.textColor = UIColor.Compatible.secondaryLabel
    }
}
