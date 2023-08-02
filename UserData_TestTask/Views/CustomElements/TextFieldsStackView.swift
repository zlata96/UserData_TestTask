// TextFieldsStackView.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - TextFieldsStackView

class TextFieldsStackView: UIView {
    lazy var nameTextFieldView = TextFieldView(
        text: "Имя",
        placeholder: "Укажите ",
        type: .default
    )

    private lazy var ageTextFieldView = TextFieldView(
        text: "Возраст",
        placeholder: "Укажите ",
        type: .numberPad
    )

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = .white
    }

    private func addSubviews() {
        stackView.addArrangedSubview(nameTextFieldView)
        stackView.addArrangedSubview(ageTextFieldView)
        addSubview(stackView)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TextFieldsStackView {
    func resetData() {
        nameTextFieldView.textField.text?.removeAll()
        ageTextFieldView.textField.text?.removeAll()
    }

    func configure(namePlaceholder: String, agePlaceholder: String) {
        nameTextFieldView.textField.placeholder = namePlaceholder
        ageTextFieldView.textField.placeholder = agePlaceholder
    }
}
