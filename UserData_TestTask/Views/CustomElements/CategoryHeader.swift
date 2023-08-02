// CategoryHeader.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - AddButtonDelegate

protocol AddButtonDelegate: AnyObject {
    func addButtonPressed()
}

// MARK: - CategoryHeader

class CategoryHeader: UICollectionReusableView {
    var addButtonDelegate: AddButtonDelegate?

    private var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private var addButton = AddButton()

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
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(addButton)
        addSubview(categoryNameLabel)
    }

    private func makeConstraints() {
        categoryNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryNameLabel.snp.trailing).offset(16)
            $0.height.equalTo(42)
        }
    }

    private func setupTargets() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
}

extension CategoryHeader {
    @objc
    func addButtonPressed() {
        addButtonDelegate?.addButtonPressed()
    }

    func configure(title: String, isButtonHidden: Bool) {
        categoryNameLabel.text = title
        addButton.isHidden = isButtonHidden
    }

    func hideAddButton(isHidden: Bool) {
        addButton.isHidden = isHidden
    }
}
