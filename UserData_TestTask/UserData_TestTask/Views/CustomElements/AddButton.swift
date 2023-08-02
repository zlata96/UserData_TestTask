// AddButton.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

class AddButton: UIButton {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Добавить ребенка"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .systemBlue
        return imageView
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
        addSubviews()
        makeConstraints()
        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .white
        layer.cornerRadius = 21
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 2
    }

    private func addSubviews() {
        addSubview(plusImageView)
        addSubview(label)
    }

    private func makeConstraints() {
        plusImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(plusImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
