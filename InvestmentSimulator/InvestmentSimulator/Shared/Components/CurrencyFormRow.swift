//
//  CurrencyFormRow.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import UIKit
import Cartography
import CurrencyTextField

// MARK: - CurrencyFormRow
class CurrencyFormRow: UIView {
    // MARK: Properties
    private(set) var title: String = ""
    private(set) var placeholder: String = ""
    private(set) var isRequired: Bool = false
    public var didChangeText: ((String?) -> Void)?
    // MARK: UI components
    private lazy var titleLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var inputField: CurrencyTextField = { return CurrencyTextField(frame: .zero) }()
    private lazy var bottomLine: UIView = { return UIView(frame: .zero) }()
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
    // MARK: Setters
    func updateView(title: String = "",
                    placeholder: String = "",
                    isRequired: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self.isRequired = isRequired
        inputField.placeholder = placeholder
        titleLabel.text = "\(title)\(isRequired ? " *" : "")"
    }
}

// MARK: - View Code Configuration
extension CurrencyFormRow: ViewCodeConfiguration {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(inputField)
        addSubview(bottomLine)
    }
    func setupConstraint() {
        // Title
        Cartography.constrain(titleLabel, self) { title, view in
            title.top == view.top
            title.left == view.left
            title.right == view.right
        }
        // InputField
        Cartography.constrain(inputField, self) { input, view in
            input.left == view.left
            input.right == view.right
        }
        Cartography.constrain(inputField, titleLabel) { input, title in
            input.top == title.bottom + 16
        }
        // BottomLine
        Cartography.constrain(bottomLine, inputField) { bottom, input in
            bottom.top == input.bottom + 8
        }
        Cartography.constrain(bottomLine, self) { bottom, view in
            bottom.height == 1
            bottom.left == view.left
            bottom.right == view.right
            bottom.bottom == view.bottom
        }
    }
    func setupViews() {
        // Title
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor.Compatible.secondaryLabel
        // InputField
        inputField.textAlignment = .center
        inputField.placeholder = placeholder
        inputField.keyboardType = .decimalPad
        inputField.adjustsFontForContentSizeCategory = true
        inputField.font = .preferredFont(forTextStyle: .largeTitle)
        inputField.textColor = UIColor.Compatible.secondaryLabel
        inputField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        // BottomLine
        bottomLine.backgroundColor = .gray
    }
}

// MARK: - Actions
extension CurrencyFormRow {
    @objc
    func editingChanged(_ textField: UITextField) {
        didChangeText?(textField.text)
    }
}
