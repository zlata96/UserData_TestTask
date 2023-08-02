// UICollectionView+Extension.swift
// UserData_TestTask. Created by Zlata Guseva.

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }

    func register<T: UICollectionReusableView>(viewWithClass name: T.Type, forSupplementaryViewOfKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    func viewForSupplementary<T: UICollectionReusableView>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: name),
            for: indexPath
        ) as? T else { fatalError("Cannot create the header") }

        return view
    }
}
