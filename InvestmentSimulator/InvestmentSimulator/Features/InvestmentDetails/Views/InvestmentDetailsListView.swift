//
//  InvestmentDetailsListView.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 13/02/21.
//

import UIKit
import Cartography

// MARK: - InvestmentDetailsListView
class InvestmentDetailsListView: UIView {
    // MARK: Computed Properties
    var viewModel: InvestmentDetailsListViewModel? {
        didSet { bindProperties() }
    }
    // MARK: UI components
    private lazy var stackView: UIStackView = { return UIStackView(frame: .zero) }()
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
    private func bindProperties() {
        viewModel?.itens.forEach { item in
            let viewModel = InvestmentDetailsItemViewModel(
                title: item.title,
                value: item.value
            )
            self.stackView.addArrangedSubview(InvestmentDetailsListItemView(viewModel: viewModel))
        }
    }
}

// MARK: - View Code Configuration
extension InvestmentDetailsListView: ViewCodeConfiguration {
    func setupHierarchy() {
        addSubview(stackView)
    }
    func setupConstraint() {
        Cartography.constrain(stackView, self) { stack, view in
            stack.edges == view.edges
        }
    }
    func setupViews() {
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        bindProperties()
    }
}
