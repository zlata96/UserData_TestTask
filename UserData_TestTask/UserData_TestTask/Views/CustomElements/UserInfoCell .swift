// UserInfoCell .swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - UserInfoCell

class UserInfoCell: UICollectionViewCell {
    // TODO: Stack
    private var nameTextFieldView = TextFieldView(text: "Имя", placeholder: "Укажите Ваше ФИО", type: .default)
    private var ageTextFieldView = TextFieldView(text: "Возраст", placeholder: "Укажите Ваш возраст", type: .numberPad)

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
        addSubview(nameTextFieldView)
        addSubview(ageTextFieldView)
    }

    private func makeConstraints() {
        nameTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        ageTextFieldView.snp.makeConstraints {
            $0.top.equalTo(nameTextFieldView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension UserInfoCell {
    func resetData() {
        nameTextFieldView.textField.text?.removeAll()
        ageTextFieldView.textField.text?.removeAll()
    }
}
