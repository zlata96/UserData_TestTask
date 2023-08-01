// UserInfoView.swift
// UserData_TestTask. Created by Zlata Guseva.

import SnapKit
import UIKit

// MARK: - ResetDataDelegate

protocol ResetDataDelegate {
    func resetButtonPressed()
}

// MARK: - UserInfoView

class UserInfoView: UIView {
    var resetDataDelegate: ResetDataDelegate?
    lazy var userInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            CategoryHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.reuseIdentifier
        )
        collectionView.register(cellWithClass: UserInfoCell.self)
        collectionView.register(cellWithClass: ChildInfoCell.self)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var cleanButton: UIButton = {
        var button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 24
        // TODO: colors
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
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
        setupStyle()
        addSubviews()
        makeConstraints()
        setupTargets()
    }

    private func setupStyle() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(userInfoCollectionView)
        addSubview(cleanButton)
    }

    private func makeConstraints() {
        userInfoCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(400)
        }

        cleanButton.snp.makeConstraints {
            $0.top.equalTo(userInfoCollectionView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(64)
        }
    }

    private func setupTargets() {
        cleanButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }

    @objc
    func resetButtonPressed() {
        resetDataDelegate?.resetButtonPressed()
    }
}
