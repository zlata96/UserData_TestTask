// UserInfoCell .swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - UserInfoCell

class UserInfoCell: UICollectionViewCell {
    private var userTextFieldStackView = TextFieldsStackView()

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
        userTextFieldStackView.configure(namePlaceholder: "Укажите Ваше ФИО", agePlaceholder: "Укажите Ваш возраст")
        userTextFieldStackView.nameTextFieldView.textField.textContentType = .name
    }

    private func addSubviews() {
        addSubview(userTextFieldStackView)
    }

    private func makeConstraints() {
        userTextFieldStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension UserInfoCell {
    func resetData() {
        userTextFieldStackView.resetData()
    }
}
