// ViewController.swift
// UserData_TestTask. Created by Zlata Guseva.

import SnapKit
import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case personalInfo = 0
        case childrenInfo
    }

    let contentView = UserInfoView()

    var numberOfChild = 1 {
        didSet {
            // Ограничеваем максимальное кол-во до 5
            if numberOfChild > 5 {
                numberOfChild = 5
            }
            isButtonInHeaderHidden(numberOfChild == 5)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setupDelegates()
        hideKeyboardWhenTappedAround()
    }

    private func setupDelegates() {
        contentView.userInfoCollectionView.dataSource = self
        contentView.userInfoCollectionView.delegate = self
        contentView.resetDataDelegate = self
    }

    private func updateCollectionViewConstraints() {
        let height = contentView.userInfoCollectionView.contentSize
        contentView.userInfoCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        switch sectionType {
        case .personalInfo:
            return 1
        case .childrenInfo:
            return numberOfChild
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch sectionType {
        case .personalInfo:
            let cell = collectionView.dequeueReusableCell(withClass: UserInfoCell.self, for: indexPath)
            return cell
        case .childrenInfo:
            let cell = collectionView.dequeueReusableCell(withClass: ChildInfoCell.self, for: indexPath)
            cell.deleteButtonDelegate = self
            cell.isSeparatorHidden(numberOfChild == 1)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
        let header = collectionView.viewForSupplementary(
            withClass: CategoryHeader.self,
            for: indexPath
        )
        header.addButtonDelegate = self

        switch sectionType {
        case .personalInfo:
            header.configure(title: "Персональные данные", isButtonHidden: true)
        case .childrenInfo:
            header.configure(title: "Дети (макс. 5)", isButtonHidden: false)
        }
        return header
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 48)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 160)
    }

    private func isButtonInHeaderHidden(_ isHidden: Bool) {
        let indexPath = IndexPath(row: 0, section: 1)
        if let headerView = contentView.userInfoCollectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        ) as? CategoryHeader {
            headerView.hideAddButton(isHidden: isHidden)
        }
    }
}

// MARK: AddButtonDelegate

extension ViewController: AddButtonDelegate {
    func addButtonPressed() {
        numberOfChild += 1
        contentView.userInfoCollectionView.insertItems(at: [IndexPath(row: numberOfChild - 1, section: 1)])
        updateCollectionViewConstraints()
    }
}

// MARK: DeleteButtonDelegate

extension ViewController: DeleteButtonDelegate {
    func deleteButtonPressed() {
        if numberOfChild > 0 {
            let indexPath = IndexPath(row: numberOfChild - 1, section: 1)
            numberOfChild -= 1
            contentView.userInfoCollectionView.deleteItems(at: [indexPath])
            updateCollectionViewConstraints()
        }
    }
}

// MARK: ResetDataDelegate

extension ViewController: ResetDataDelegate {
    func resetButtonPressed() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { [weak self] _ in
            self?.resetData()
        }))

        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }

    private func resetData() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = contentView.userInfoCollectionView.cellForItem(at: indexPath) as? UserInfoCell
        cell?.resetData()

        numberOfChild = 1
        contentView.userInfoCollectionView.reloadSections([1])
        updateCollectionViewConstraints()
    }
}
