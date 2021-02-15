//
//  DateFormRowView.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import UIKit
import Cartography
import AnyFormatKit

// MARK: - DateFormRowView
class DateFormRowView: UIView {
    // MARK: Properties
    private(set) var title: String = ""
    private(set) var placeholder: String = ""
    private(set) var isRequired: Bool = false
    public var didChangeText: ((String?) -> Void)?
    private let dateFormatter = DefaultTextInputFormatter(textPattern: "##/##/####")
    private let dateInputController = DateTextFieldInputController()
    // MARK: UI components
    private lazy var titleLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var inputField: UITextField = { return UITextField(frame: .zero) }()
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
extension DateFormRowView: ViewCodeConfiguration {
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
        inputField.keyboardType = .numberPad
        inputField.adjustsFontForContentSizeCategory = true
        inputField.font = .preferredFont(forTextStyle: .largeTitle)
        inputField.textColor = UIColor.Compatible.secondaryLabel
        inputField.delegate = dateInputController
        dateInputController.formatter = dateFormatter
        dateInputController.didChangeText = { [weak self] text in
            self?.didChangeText?(text)
        }
        // BottomLine
        bottomLine.backgroundColor = .gray
    }
}

class DateTextFieldInputController: NSObject, UITextFieldDelegate {
    var formatter: TextInputFormatter?
    var didChangeText: ((String?) -> Void)?
    open func textField(_ textField: UITextField,
                        shouldChangeCharactersIn range: NSRange,
                        replacementString string: String) -> Bool {
        guard let formatter = formatter else { return true }
        let result = formatter.formatInput(
            currentText: textField.text ?? "",
            range: range,
            replacementString: string
        )
        textField.text = result.formattedText
        textField.setCursorLocation(result.caretBeginOffset)
        didChangeText?(result.formattedText)
        return false
    }
}
