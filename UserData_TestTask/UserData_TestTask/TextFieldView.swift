// TextFieldView.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

class TextFieldView: UIView {
    var text: String
    var placeholder: String
    var type: UIKeyboardType

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray]
        )
        textField.textColor = .black
        textField.keyboardType = type
        return textField
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
    }

    private func setupStyle() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.gray.cgColor
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
}
