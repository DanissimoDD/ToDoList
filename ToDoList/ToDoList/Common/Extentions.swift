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

extension UIColor {
	convenience init(fromHex hex: String) {
		var rgbValue: UInt64 = 0
		let scanner = Scanner(string: hex)
		scanner.scanHexInt64(&rgbValue)
		
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0xFF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}

extension Date {
	func formattedDayAndTime() -> [String] {
		var dayString = ""
		
		if Calendar.current.isDateInToday(self) {
			dayString = "Today"
		} else {
			let dateFormatterDay = DateFormatter()
			dateFormatterDay.dateFormat = "d MMMM"
			dayString = dateFormatterDay.string(from: self)
		}
		
		let dateFormatterTime = DateFormatter()
		dateFormatterTime.dateFormat = "hh:mm a"
		let timeString = dateFormatterTime.string(from: self)
		
		return [dayString, timeString]
	}
}
