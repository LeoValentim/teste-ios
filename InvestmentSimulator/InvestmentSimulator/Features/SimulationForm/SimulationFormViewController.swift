//
//  SimulationFormViewController.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import UIKit
import Cartography

class SimulationFormViewController: UIViewController {
    // MARK: Properties
    var interactor: SimulationFormBusinessLogic?
    // MARK: UI components
    private lazy var stackView: UIStackView = { return UIStackView(frame: .zero) }()
    private lazy var investedAmountRow: CurrencyFormRow = { return CurrencyFormRow(frame: .zero) }()
    private lazy var maturityDateRow: DateFormRowView = { return DateFormRowView(frame: .zero) }()
    private lazy var rateRow: PercentageFormRow = { return PercentageFormRow(frame: .zero) }()
    private lazy var simulateButton: CustomButton = { return CustomButton(frame: .zero) }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constructViews()
    }
}

// MARK: - View Code Configuration
extension SimulationFormViewController: ViewCodeConfiguration {
    func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(investedAmountRow)
        stackView.addArrangedSubview(maturityDateRow)
        stackView.addArrangedSubview(rateRow)
        stackView.addArrangedSubview(simulateButton)
    }
    func setupConstraint() {
        Cartography.constrain(stackView, view) { stack, view in
            stack.center == view.center
            stack.left == view.left + 24
            stack.right == view.right - 24
        }
        Cartography.constrain(simulateButton) { button in
            button.height == 44
        }
    }
    func setupViews() {
        // Stack
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 24
        // InvestedAmount
        investedAmountRow.updateView(title: "Quanto você gostaria de aplicar?",
                                     placeholder: "R$",
                                     isRequired: true)
        investedAmountRow.didChangeText = { [weak self] text in
            self?.interactor?.didChange(investedAmount: text)
        }
        // MaturityDate
        maturityDateRow.updateView(title: "Qual a data de vencimento do investimento?",
                                   placeholder: "dia/mês/ano",
                                   isRequired: true)
        maturityDateRow.didChangeText = { [weak self] text in
            self?.interactor?.didChange(maturityDate: text)
        }
        // Rate
        rateRow.updateView(title: "Qual o percentual do CDI do investimento?",
                           placeholder: "100%",
                           isRequired: true)
        rateRow.didChangeText = { [weak self] text in
            self?.interactor?.didChange(rate: text)
        }
        // Simulate button
        simulateButton.isEnabled = false
        simulateButton.setTitle("Simular", for: .normal)
        simulateButton.addTarget(self, action: #selector(simulateAction), for: .touchUpInside)
    }
}

// MARK: - Actions
extension SimulationFormViewController {
    @objc
    func simulateAction() {
        interactor?.submitForm()
    }
}

// MARK: - Output
protocol SimulationFormOutput: class {
    func changeSubmitButtonState(isEnable: Bool)
    func didFailure(_ error: Error)
}
extension SimulationFormViewController: SimulationFormOutput {
    func changeSubmitButtonState(isEnable: Bool) {
        simulateButton.isEnabled = isEnable
    }
    func didFailure(_ error: Error) {
        let alert = UIAlertController(title: "Ooops!", message: "Ocorreu um erro.", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}
