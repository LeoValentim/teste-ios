//
//  InvestmentDetailsViewController.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import UIKit
import Cartography

// MARK: - InvestmentDetails ViewController
class InvestmentDetailsViewController: UIViewController, XIBInstantiable {
    // MARK: Properties
    var interactor: InvestmentDetailsBusinessLogic?
    // MARK: UI components
    @IBOutlet weak var grossAmountLabel: UILabel!
    @IBOutlet weak var grossAmountProfitLabel: UILabel!
    @IBOutlet weak var firstDetailsListView: InvestmentDetailsListView!
    @IBOutlet weak var secondDetailsListView: InvestmentDetailsListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        interactor?.loadDetails()
    }
    func bindProperties(_ viewModel: InvestmentDetailsViewModel) {
        // Gross Amount
        grossAmountLabel.text = viewModel.grossAmount
        // Gross Amount Profit
        let regularText = "Rendimento total de "
        let coloredText = viewModel.grossAmountProfit
        let grossAmountProfit = "\(regularText)\(coloredText)"
        let attributedString = NSMutableAttributedString(string: grossAmountProfit)
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .caption2)
        ]
        attributedString.addAttributes(attributes1,
                                       range: NSRange(location: 0, length: grossAmountProfit.count))
        let attributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.defaultColor,
            .font: UIFont.preferredFont(forTextStyle: .caption2)
        ]
        attributedString.addAttributes(attributes2,
                                       range: NSRange(location: regularText.count,
                                                      length: coloredText.count))
        grossAmountProfitLabel.attributedText = attributedString
    }
}

// MARK: - Action
extension InvestmentDetailsViewController {
    @IBAction func simulateAgainAction(_ sender: Any?) {
        interactor?.simulateAgain()
    }
}

// MARK: - Output
protocol InvestmentDetailsOutput: class {
    func displayDetails(_ viewModel: InvestmentDetailsViewModel)
    func didFailure(_ error: Error)
}
extension InvestmentDetailsViewController: InvestmentDetailsOutput {
    func displayDetails(_ viewModel: InvestmentDetailsViewModel) {
        bindProperties(viewModel)
        firstDetailsListView.viewModel = viewModel.firstDetailsList
        secondDetailsListView.viewModel = viewModel.secondDetailsList
    }
    func didFailure(_ error: Error) {
        let alert = UIAlertController(title: "Ooops!", message: "Ocorreu um erro.", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}
