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

    private lazy var childTextFieldsStackView = TextFieldsStackView()

    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentMode = .topLeft
        return button
    }()

    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        setupTargets()
    }

    private func setupStyle() {
        childTextFieldsStackView.configure(
            namePlaceholder: "Укажите имя ребенка",
            agePlaceholder: "Укажите возраст ребенка"
        )
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(childTextFieldsStackView)
        addSubview(deleteButton)
        addSubview(separatorView)
    }

    private func makeConstraints() {
        childTextFieldsStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(16)
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
            $0.height.equalTo(140)
        }

        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(childTextFieldsStackView.snp.trailing).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2 - 32)
        }

        separatorView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func setupTargets() {
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
    }
}

extension ChildInfoCell {
    func resetData() {
        childTextFieldsStackView.resetData()
    }

    func isSeparatorHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }

    @objc
    func deleteButtonPressed() {
        deleteButtonDelegate?.deleteButtonPressed()
    }
}
