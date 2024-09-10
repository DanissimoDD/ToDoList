//
//  MainScreenCollectionViewCell.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

final class MainScreenCollectionViewCell: UICollectionViewCell {
	private let textLabel = {
		let label = UILabel()
		label.text = "Client Review & Feedback"
		label.font = .systemFont(ofSize: 18, weight: .medium)
		return label
	} ()
	
	private let subTextLabel = {
		let label = UILabel()
		label.text = "Subtask"
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .gray
		return label
	} ()
	
	private let dateLabel = {
		let label = UILabel()
		label.text = "Date"
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .gray
		return label
	} ()
	
	private let devider = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 240/256, green: 240/256, blue: 240/256, alpha: 1)
		return view
	} ()
	
	private let checkMark = {
		let check = UIImageView()
		return check
	} ()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension MainScreenCollectionViewCell {
	func setupView() {
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 20
		contentView.addSubviews(textLabel, subTextLabel, dateLabel, devider, checkMark)
	}
	
	func setupLayout() {
		disableAutoresizingMaskTranslation(textLabel, subTextLabel, dateLabel, devider, checkMark)
		
		NSLayoutConstraint.activate([
			textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			textLabel.heightAnchor.constraint(equalToConstant: 30),
			textLabel.trailingAnchor.constraint(equalTo: checkMark.leadingAnchor, constant: -8),
			
			subTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
			subTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
			subTextLabel.heightAnchor.constraint(equalToConstant: 24),
			subTextLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
			
			checkMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
			checkMark.heightAnchor.constraint(equalToConstant: 32),
			checkMark.widthAnchor.constraint(equalToConstant: 32),
			checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
			
			devider.topAnchor.constraint(equalTo: subTextLabel.bottomAnchor, constant: 8),
			devider.heightAnchor.constraint(equalToConstant: 1),
			devider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			devider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			dateLabel.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 8),
			dateLabel.heightAnchor.constraint(equalToConstant: 24),
			dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
		])
	}
}

extension MainScreenCollectionViewCell {
	func configure(model: MainScreenItemModel) {
//		textLabel.text = model.title
//		subTextLabel.text = model.subTitle
		checkMark.image = /*model.hasDone ? UIImage(systemName: "checkmark.circle.fill") :*/ UIImage(systemName: "circle")
		// Добавить обработку даты
	}
}
