//
//  TaskScreenViewController.swift
//  ToDoList
//
//  Created by Danil Viugov on 11.09.2024.
//

import UIKit

protocol TaskScreenViewInput: AnyObject {
	func setData(model: MainScreenItemModel)
}

final class TaskScreenViewController: UIViewController {
	
	private let output: TaskScreenViewOutput
	
	init(presenter: TaskScreenViewOutput) {
		self.output = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let doneButton = {
		let button = UIButton(type: .system)  // Устанавливаем заголовок
		let attributedTitle = NSAttributedString(string: "Done",
			attributes: [
				.font: UIFont.systemFont(ofSize: 20),
				.foregroundColor: UIColor.white
			]
		)
		button.setAttributedTitle(attributedTitle, for: .normal)
		button.layer.cornerRadius = 10
		button.clipsToBounds = true
		button.backgroundColor = .systemBlue.withAlphaComponent(0.5)

		button.contentHorizontalAlignment = .center
		return button
	} ()
	
	private let deletionButton = {
		let button = UIButton(type: .system)
		let attributedTitle = NSAttributedString(string: "Delete",
			attributes: [
				.font: UIFont.systemFont(ofSize: 20),
				.foregroundColor: UIColor.white
			]
		)
		button.setAttributedTitle(attributedTitle, for: .normal)
		button.layer.cornerRadius = 10
		button.clipsToBounds = true
		button.backgroundColor = .systemRed.withAlphaComponent(0.5)

		button.contentHorizontalAlignment = .center
		return button
	} ()

	private let titleLable = {
		let label = UILabel()
		label.text = "Create new task"
		label.font = .systemFont(ofSize: 24, weight: .bold)
		label.textColor = .black
		return label
	} ()

	private let titleTextField = {
		let textField = UITextField()
		textField.backgroundColor = UIColor(fromHex: "F0F0F0")
		textField.font = UIFont.systemFont(ofSize: 18)
		textField.textColor = UIColor.black
		textField.layer.cornerRadius = 12
		textField.clipsToBounds = true
		textField.attributedPlaceholder = NSAttributedString(string: "Task title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
		textField.leftViewMode = .always
		return textField
	} ()

	private let subtitleTextField = {
		let textField = UITextField()
		textField.backgroundColor = UIColor(fromHex: "F0F0F0")
		textField.font = UIFont.systemFont(ofSize: 18)
		textField.textColor = UIColor.black
		textField.layer.cornerRadius = 12
		textField.clipsToBounds = true
		textField.attributedPlaceholder = NSAttributedString(string: "Discription", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
		textField.leftViewMode = .always
		return textField
	} ()

	private let dateTitleLable = {
		let label = UILabel()
		label.text = "Deadline"
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		label.textColor = .black
		return label
	} ()
	
	private let dataPicker = {
		let picker = UIDatePicker()
		picker.preferredDatePickerStyle = .automatic
		picker.locale = .current
		return picker
	} ()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupLayout()
		setupButtons()
		output.viewDidLoad()
	}
	
	// MARK: - Private setup methods
	
	private func setupView() {
		view.backgroundColor = .white
		view.addSubviews(
			doneButton,
			titleLable,
			titleTextField,
			subtitleTextField,
			dataPicker,
			dateTitleLable,
			deletionButton
		)
	}
	
	private func setupLayout() {
		view.disableAutoresizingMaskTranslation(
			doneButton,
			titleLable,
			titleTextField,
			subtitleTextField,
			dataPicker,
			dateTitleLable,
			deletionButton
		)

		NSLayoutConstraint.activate([
			doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
			doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			doneButton.widthAnchor.constraint(equalToConstant: 70),
			doneButton.heightAnchor.constraint(equalToConstant: 34),
			
			deletionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
			deletionButton.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -12),
			deletionButton.widthAnchor.constraint(equalToConstant: 70),
			deletionButton.heightAnchor.constraint(equalToConstant: 34),
			
			titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
			titleLable.trailingAnchor.constraint(equalTo: deletionButton.leadingAnchor, constant: -8),
			titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			titleLable.heightAnchor.constraint(equalToConstant: 30),
			
			titleTextField.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 28),
			titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			titleTextField.heightAnchor.constraint(equalToConstant: 44),
			
			subtitleTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
			subtitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			subtitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			subtitleTextField.heightAnchor.constraint(equalToConstant: 44),
			
			dateTitleLable.topAnchor.constraint(equalTo: subtitleTextField.bottomAnchor, constant: 8),
			dateTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			dateTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			dateTitleLable.heightAnchor.constraint(equalToConstant: 44),
			
			dataPicker.topAnchor.constraint(equalTo: dateTitleLable.bottomAnchor, constant: 16),
			dataPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			dataPicker.heightAnchor.constraint(equalToConstant: 32),
			dataPicker.widthAnchor.constraint(equalToConstant: 200),
		])
	}
	
	private func setupButtons() {
		doneButton.addAction(UIAction {
			[weak self] _ in
			guard let self = self else { return }
			output.finishTaskCreation(
				newModel: TaskScreenModel(
					title: titleTextField.text ?? "",
					subTitle: subtitleTextField.text ?? "",
					dateTime: dataPicker.date
				)
			)
		},
							 for: .touchUpInside)

		if output.isEditMode() {
			deletionButton.addAction(UIAction {
				[weak self] _ in
				guard let self = self else { return }
				output.taskDeletion()
			},
									 for: .touchUpInside)
		} else {
			deletionButton.removeFromSuperview()
		}
	}
}

// MARK: - TaskScreenViewInput

extension TaskScreenViewController: TaskScreenViewInput {
	func setData(model: MainScreenItemModel) {
		titleTextField.text = model.title
		subtitleTextField.text = model.subTitle
		dataPicker.setDate(model.dateTime, animated: false)
	}
}
