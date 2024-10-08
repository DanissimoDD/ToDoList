//
//  ToastView.swift
//  ToDoList
//
//  Created by Danil Viugov on 15.09.2024.
//

import UIKit


final class ToastView: UIView {

	private let toastLabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	} ()
	
	init(message: String) {
		super.init(frame: .zero)
		setupView()
		setupLayout()
		setupUI(message: message)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		addSubview(toastLabel)
		
		backgroundColor = UIColor.red.withAlphaComponent(0.6)
		layer.cornerRadius = 10
		clipsToBounds = true
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 4
	}
	
	private func setupUI(message: String) {
		toastLabel.text = message
	}
	
	private func setupLayout() {
		toastLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			toastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			toastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			toastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			toastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])
	}
}
