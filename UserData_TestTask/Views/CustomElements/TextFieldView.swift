// TextFieldView.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

class TextFieldView: UIView {
    var onTextChanged: ((String) -> Void)?
    var text: String
    var placeholder: String
    var type: UIKeyboardType

    lazy var textField: UITextField = {
        var textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.keyboardType = type
        return textField
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    required init(text: String, placeholder: String, type: UIKeyboardType) {
        self.type = type
        self.text = text
        self.placeholder = placeholder
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }

    private func setupStyle() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = CGFloat(1)
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(textField)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.top.equalToSuperview().offset(8)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }

    @objc private func textFieldChanged(_ textField: UITextField) {
        onTextChanged?(textField.text ?? "")
    }
}
