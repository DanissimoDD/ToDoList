//
//  MainScreenViewController.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenViewInput: AnyObject {
	func updateDataSource(models: [MainScreenItemModel])
	
	func showToast(message: String, duration: TimeInterval)
}

final class MainScreenViewController: UIViewController {
	
	private let output: MainScreenViewOutput
	
	private let titleLabel = {
		let label = UILabel()
		label.text = "Today's Task"
		label.textColor = .black
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	} ()
	
	private let dateLabel = {
		let label = UILabel()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE, dd MMMM"
		label.text = dateFormatter.string(from: Date())
		label.font = .systemFont(ofSize: 14, weight: .medium)
		label.textColor = .gray
		return label
	} ()
	
	private let addTaskButton = {
		let button = UIButton()
		button.backgroundColor = .blue.withAlphaComponent(0.15)
		button.setTitle("+ New Task", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
		button.setTitleColor(.blue, for: .normal)
		button.setTitleColor(.blue.withAlphaComponent(0.5), for: .highlighted)
		button.clipsToBounds = true
		button.layer.cornerRadius = 16
		return button
	} ()

	private let collectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = CGSize(width: 360, height: 130)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.allowsMultipleSelection = false
		collectionView.alwaysBounceVertical = false
		collectionView.backgroundColor = .clear
		collectionView.layer.cornerRadius = 20
		collectionView.registerCell(MainScreenCollectionViewCell.self)
		return collectionView
	} ()
	
	var dataSource: UICollectionViewDiffableDataSource<MainScreenSectionModel, MainScreenItemModel>?

	init(presenter: MainScreenViewOutput) {
		self.output = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupLayout()
		setupButtonAction()
		collectionView.delegate = self
		setupDataSource()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		output.viewDidLoad()
	}
}

private extension MainScreenViewController {
	func setupView() {
		view.backgroundColor = UIColor(red: 245/256, green: 245/256, blue: 245/256, alpha: 1)
		view.addSubviews(titleLabel, dateLabel, addTaskButton, collectionView)
	}
	
	func setupLayout() {
		view.disableAutoresizingMaskTranslation(titleLabel, dateLabel, addTaskButton, collectionView)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor/*, constant: 16*/),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: addTaskButton.leadingAnchor,  constant: -8),
			titleLabel.heightAnchor.constraint(equalToConstant: 24),
			
			dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			dateLabel.heightAnchor.constraint(equalToConstant: 18),
			
			addTaskButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 8),
			addTaskButton.widthAnchor.constraint(equalToConstant: 120),
			addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			addTaskButton.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
			
			collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			collectionView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	func setupButtonAction() {
		addTaskButton.addAction(UIAction { [weak self]
			_ in
			guard let self else { return }
			output.createNewTask()
		}, for: .touchUpInside)
	}
	
	func setupDataSource() {
		let action = actionForCell()
		dataSource = UICollectionViewDiffableDataSource(
			collectionView: collectionView,
			cellProvider: {
				collectionView, indexPath, item in
				let cell: MainScreenCollectionViewCell = collectionView.dequeueCell(indexPath)
				cell.configure(model: item, cellRow: indexPath.item, action: action)
				return cell
			}
		)
	}
	
	func actionForCell() -> UIAction {
		UIAction { [weak self]
			localActon in
			guard let self else { return }
			if let sender = localActon.sender,
			   let indexPath = indexPath(of: sender) {
				self.output.anyCheckMarkTapped(item: indexPath.item)
			}
		}
	}
	
	func indexPath(of element:Any) -> IndexPath? {
		if let view =  element as? UIView {
			let pos = view.convert(CGPoint.zero, to: collectionView)
			return collectionView.indexPathForItem(at: pos)
		}
		return nil
	}
}

extension MainScreenViewController: MainScreenViewInput {
	func updateDataSource(models: [MainScreenItemModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<MainScreenSectionModel, MainScreenItemModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(models)
		dataSource?.apply(snapshot)
	}
	

	func showToast(message: String, duration: TimeInterval) {
		
		let toastView = ToastView(message: message)

		// Получаем текущее окно
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
				// Добавляем toastView в окно
				window.addSubview(toastView)
				toastView.translatesAutoresizingMaskIntoConstraints = false

				// Устанавливаем ограничения для toastView
				NSLayoutConstraint.activate([
					toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
					toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -100),
					toastView.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
					toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50) // Минимальная высота
				])

				// Анимация появления
				toastView.alpha = 0.0
				UIView.animate(withDuration: 0.5) {
					toastView.alpha = 1.0
				} completion: { _ in
					// Анимация исчезновения через заданный интервал
					UIView.animate(withDuration: 0.5, delay: duration, options: [], animations: {
						toastView.alpha = 0.0
					}) { _ in
						// Удаляем toast после завершения анимации
						toastView.removeFromSuperview()
					}
				}
			}
		}
	}
}


extension MainScreenViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output.showTask(index: indexPath.row)
	}
}


