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
		label.textColor = .black
		label.font = .systemFont(ofSize: 18, weight: .medium)
		return label
	} ()
	
	private let subTextLabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .gray
		return label
	} ()
	
	private let dateLabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .gray
		return label
	} ()
	
	private let devider = {
		let view = UIView()
		view.backgroundColor = UIColor(fromHex: "F0F0F0")
		return view
	} ()
	
	private let markImage = UIImageView()
	
	private let checkButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private setup methods
	
	private func setupView() {
		backgroundColor = .white
		layer.cornerRadius = 20
		addSubviews(textLabel, subTextLabel, dateLabel, devider, checkButton, markImage)
	}
	
	private func setupLayout() {
		disableAutoresizingMaskTranslation(textLabel, subTextLabel, dateLabel, devider, checkButton, markImage)
		
		NSLayoutConstraint.activate([
			textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			textLabel.heightAnchor.constraint(equalToConstant: 30),
			textLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -8),
			
			subTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
			subTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
			subTextLabel.heightAnchor.constraint(equalToConstant: 24),
			subTextLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
			
			checkButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			checkButton.heightAnchor.constraint(equalToConstant: 48),
			checkButton.widthAnchor.constraint(equalToConstant: 48),
			checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			markImage.topAnchor.constraint(equalTo: topAnchor, constant: 24),
			markImage.heightAnchor.constraint(equalToConstant: 32),
			markImage.widthAnchor.constraint(equalToConstant: 32),
			markImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			
			devider.topAnchor.constraint(equalTo: subTextLabel.bottomAnchor, constant: 8),
			devider.heightAnchor.constraint(equalToConstant: 1),
			devider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			devider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			dateLabel.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 8),
			dateLabel.heightAnchor.constraint(equalToConstant: 24),
			dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}
}

extension MainScreenCollectionViewCell {
	func configure(model: MainScreenItemModel, cellRow: Int, action: UIAction) {
		if model.hasDone {
			let attributedString = NSMutableAttributedString(string: model.title)
			attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, model.title.count))
			textLabel.attributedText = attributedString
		} else {
			textLabel.attributedText = .none
			textLabel.text = model.title
		}
		subTextLabel.text = model.subTitle
		markImage.image = model.hasDone ? UIImage(systemName: "checkmark.circle.fill") :
		UIImage(systemName: "circle")
		checkButton.tag = cellRow
		checkButton.addAction(action, for: .touchUpInside)
		let timeStrings = model.dateTime.formattedDayAndTime()
		dateLabel.text = "\(timeStrings[0]), \(timeStrings[1])"
	}
}
