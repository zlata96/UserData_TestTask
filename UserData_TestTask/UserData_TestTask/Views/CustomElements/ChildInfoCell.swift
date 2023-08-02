// ChildInfoCell.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - DeleteButtonDelegate

protocol DeleteButtonDelegate: AnyObject {
    func deleteButtonPressed()
}

// MARK: - ChildInfoCell

class ChildInfoCell: UICollectionViewCell {
    var deleteButtonDelegate: DeleteButtonDelegate?
    // TODO: Stack
    private var nameTextFieldView = TextFieldView(text: "Имя",
                                                  placeholder: "Укажите имя ребенка",
                                                  type: .default)
    private var ageTextFieldView = TextFieldView(text: "Возраст",
                                                 placeholder: "Укажите возраст ребенка",
                                                 type: .numberPad)

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentMode = .topLeft
        return button
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
        backgroundColor = .white
        addSubviews()
        makeConstraints()
        setupTargets()
    }

    private func addSubviews() {
        stackView.addArrangedSubview(nameTextFieldView)
        stackView.addArrangedSubview(ageTextFieldView)
        addSubview(stackView)
        addSubview(deleteButton)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
            $0.height.equalTo(140)
        }

        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(stackView.snp.trailing).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2 - 32)
        }
    }

    private func setupTargets() {
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
    }

    @objc
    func deleteButtonPressed() {
        deleteButtonDelegate?.deleteButtonPressed()
    }

    func resetData() {
        nameTextFieldView.textField.text?.removeAll()
        ageTextFieldView.textField.text?.removeAll()
    }
}
