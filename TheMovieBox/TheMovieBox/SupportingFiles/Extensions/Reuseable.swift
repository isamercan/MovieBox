//
//  Reuseable.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

// MARK: - UITableView
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellReuseIdentifier: "\(T.self)")
    }
    
    func register(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath, identifier: String? = nil) -> T {
        if let identifier = identifier {
            return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T ?? T()
        } else {
            return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T ?? T()
        }
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cell: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(T.self)")
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T ?? T()
    }
}

// MARK: - UICollectionView
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellWithReuseIdentifier: "\(T.self)")
    }
    
    func dequeue<T: UICollectionViewCell>(cellForRowAt indexPath: IndexPath, identifier: String? = nil) -> T {
        if let identifier = identifier {
            return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T ?? T()
        } else {
            return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T ?? T()
        }
    }

    func indexPathExists(_ indexPath: IndexPath) -> Bool {
        guard indexPath.section < numberOfSections, indexPath.row < numberOfItems(inSection: indexPath.section) else { return false }
        return true
    }
}
