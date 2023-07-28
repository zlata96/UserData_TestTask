// CategoryHeader.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

class CategoryHeader: UICollectionReusableView {
    static let reuseIdentifier = "CategoryHeader"
    private var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
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
            $0.height.equalTo(32)
        }
    }

    func configure(title: String, isButtonHidden: Bool) {
        categoryNameLabel.text = title
        addButton.isHidden = isButtonHidden
    }
}
