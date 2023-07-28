// ViewController.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    let contentView = UserInfoView()
    var numberOfchild = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setupDelegates()
        // Do any additional setup after loading the view.
    }

    func setupDelegates() {
        contentView.userInfoCollectionView.dataSource = self
        contentView.userInfoCollectionView.delegate = self
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return numberOfchild
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withClass: UserInfoCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withClass: ChildInfoCell.self, for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.reuseIdentifier,
            for: indexPath
        ) as? CategoryHeader else { fatalError("Cannot create the header") }

        switch indexPath.section {
        case 0: header.configure(title: "Персональные данные", isButtonHidden: true)
        case 1: header.configure(title: "Дети (макс. 5)", isButtonHidden: false)
        default: break
        }
        return header
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 160)
    }
}
