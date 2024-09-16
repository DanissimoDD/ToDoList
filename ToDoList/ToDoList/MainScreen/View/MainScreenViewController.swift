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
	
	private let emptyLabel: UILabel = {
		let label = UILabel()
		label.text = "You have no tasks yet.\n Add tasks to get started"
		label.textColor = .black
		label.textAlignment = .center
		label.numberOfLines = 0
		label.layer.cornerRadius = 30
		label.clipsToBounds = true
		label.backgroundColor = UIColor(fromHex: "E0E0E0")
		label.font = .systemFont(ofSize: 20, weight: .semibold)
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
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(fromHex: "E0EBFE")
		button.setTitle("+ New Task", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
		button.setTitleColor(UIColor(fromHex: "447EE4"), for: .normal)
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
	
	private var dataSource: UICollectionViewDiffableDataSource<MainScreenSectionModel, MainScreenItemModel>?

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
	
	// MARK: - Private setup methods
	
	private func setupView() {
		view.backgroundColor = UIColor(fromHex: "F0F0F0")
		view.addSubviews(titleLabel, dateLabel, addTaskButton, collectionView, emptyLabel)
	}
	
	private func setupLayout() {
		view.disableAutoresizingMaskTranslation(titleLabel, dateLabel, addTaskButton, collectionView, emptyLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
			collectionView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
			
			emptyLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
			emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			emptyLabel.widthAnchor.constraint(equalToConstant: 300),
			emptyLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	private func setupButtonAction() {
		addTaskButton.addAction(UIAction { [weak self]
			_ in
			guard let self else { return }
			output.createNewTask()
		}, for: .touchUpInside)
	}
	
	private func setupDataSource() {
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
	
	private func actionForCell() -> UIAction {
		UIAction { [weak self]
			localActon in
			guard let self else { return }
			if let sender = localActon.sender,
			   let indexPath = indexPath(of: sender) {
				self.output.anyCheckMarkTapped(item: indexPath.item)
			}
		}
	}
	
	private func indexPath(of element:Any) -> IndexPath? {
		if let view =  element as? UIView {
			let pos = view.convert(CGPoint.zero, to: collectionView)
			return collectionView.indexPathForItem(at: pos)
		}
		return nil
	}
	
	private func viewDisappearance(_ view: UIView, duration: TimeInterval) {
		UIView.animate(withDuration: 0.5, delay: duration, options: [], animations: {
			view.alpha = 0.0
		}) { _ in
			view.removeFromSuperview()
		}
	}
}

// MARK: - MainScreenViewInput

extension MainScreenViewController: MainScreenViewInput {
	func updateDataSource(models: [MainScreenItemModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<MainScreenSectionModel, MainScreenItemModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(models)
		dataSource?.apply(snapshot)
		emptyLabel.isHidden = !models.isEmpty
	}

	func showToast(message: String, duration: TimeInterval) {
		let toastView = ToastView(message: message)

		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
			  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
		
		window.addSubview(toastView)
		toastView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
			toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -100),
			toastView.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
			toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50) // Минимальная высота
		])

		toastView.alpha = 0.0
		UIView.animate(withDuration: 0.5) {
			toastView.alpha = 1.0
		} completion: { [weak self]
			_ in
			self?.viewDisappearance(toastView, duration: duration)
		}
	}
}

// MARK: - UICollectionViewDelegate

extension MainScreenViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output.showTask(index: indexPath.row)
	}
}


