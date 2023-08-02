// ViewController.swift
// UserData_TestTask. Created by Zlata Guseva.

import SnapKit
import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    let contentView = UserInfoView()
    var dataArray = [""]
    var numberOfChild = 1 {
        didSet {
            if numberOfChild > 5 {
                numberOfChild = 5
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setupDelegates()
        hideKeyboardWhenTappedAround()
    }

    func setupDelegates() {
        contentView.userInfoCollectionView.dataSource = self
        contentView.userInfoCollectionView.delegate = self
        contentView.resetDataDelegate = self
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return numberOfChild
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withClass: UserInfoCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withClass: ChildInfoCell.self, for: indexPath)
            cell.deleteButtonDelegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.reuseIdentifier,
            for: indexPath
        ) as? CategoryHeader else { fatalError("Cannot create the header") }
        header.addButtonDelegate = self

        switch indexPath.section {
        case 0: header.configure(title: "Персональные данные", isButtonHidden: true)
        case 1: header.configure(title: "Дети (макс. 5)", isButtonHidden: false)
        default: break
        }
        return header
    }

    private func updateCollectionViewConctraints() {
        let height = contentView.userInfoCollectionView.contentSize
        contentView.userInfoCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
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

    private func hideButtonInHeader(isHidden: Bool) {
        let indexPath = IndexPath(row: 0, section: 1)
        if let headerView = contentView.userInfoCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? CategoryHeader {
            headerView.hideAddButton(isHidden: isHidden)
        }
    }
}

// MARK: AddButtonDelegate

extension ViewController: AddButtonDelegate {
    func addButtonPressed() {
        numberOfChild += 1
        contentView.userInfoCollectionView.insertItems(at: [IndexPath(row: numberOfChild - 1, section: 1)])
        updateCollectionViewConctraints()
        if numberOfChild == 5 {
            hideButtonInHeader(isHidden: true)
        }
    }
}

// MARK: DeleteButtonDelegate

extension ViewController: DeleteButtonDelegate {
    func deleteButtonPressed() {
        if numberOfChild != 0 {
            let indexPath = IndexPath(row: numberOfChild - 1, section: 1)
            numberOfChild -= 1
            contentView.userInfoCollectionView.deleteItems(at: [indexPath])
            updateCollectionViewConctraints()
        }
        if numberOfChild != 5 {
            hideButtonInHeader(isHidden: false)
        }
    }
}

// MARK: ResetDataDelegate

extension ViewController: ResetDataDelegate {
    func resetButtonPressed() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { [weak self] _ in
            print("pressed")
            self?.resetData()
        }))

        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }

    private func resetData() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = contentView.userInfoCollectionView.cellForItem(at: indexPath) as? UserInfoCell
        cell?.resetData()

        for index in 0 ... numberOfChild - 1 {
            let indexPath = IndexPath(item: index, section: 1)
            let cell = contentView.userInfoCollectionView.cellForItem(at: indexPath) as? ChildInfoCell
            cell?.resetData()
        }
        numberOfChild = 1
        contentView.userInfoCollectionView.reloadData()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
