//
//  AddSubviews+extention.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol Reusable: AnyObject {
	static var reuseId: String { get }
}

extension Reusable {
	static var reuseId: String {
		return String(describing: self)
	}
}

extension UICollectionView {
	func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
		register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
	}
	
	func dequeueCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
		guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell
		else { return Cell() }
		return cell
	}
}

extension UICollectionViewCell: Reusable { }

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
	
	func disableAutoresizingMaskTranslation(_ views: UIView...) {
		views.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
