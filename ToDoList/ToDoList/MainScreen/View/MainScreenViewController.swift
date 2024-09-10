//
//  MainScreenViewController.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenViewInput: AnyObject {
	func updateDataSource(models: [MainScreenItemModel])
}

final class MainScreenViewController: UIViewController {
	
	private let presenter: MainScreenViewOutput
	
	private let titleLabel = {
		let label = UILabel()
		label.text = "Today's Task"
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	} ()
	
	private let dateLabel = {
		let label = UILabel()
		label.text = "Wednesday, 11 May" // добавить обработку даты
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
		collectionView.alwaysBounceVertical = false // Почекать как будет
		collectionView.backgroundColor = .clear
//		collectionView.delegate = self
		collectionView.registerCell(MainScreenCollectionViewCell.self)
		return collectionView
	} ()
	
	private var dataSource: UICollectionViewDiffableDataSource<MainScreenSectionModel, MainScreenItemModel>?

	init(presenter: MainScreenViewOutput) {
		self.presenter = presenter
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
		setupDataSource()
		presenter.onButtonTapped()
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
//		addTaskButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
		addTaskButton.addAction(UIAction { [weak self]
			_ in
			self?.presenter.onButtonTapped()
			print(self?.dataSource)
		}, for: .touchUpInside)
	}
	
	func setupDataSource() {
		dataSource = UICollectionViewDiffableDataSource(
			collectionView: collectionView,
			cellProvider: {
				collectionView, indexPath, item in
//				let cell: MainScreenCollectionViewCell = collectionView.dequeueCell(indexPath)
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: MainScreenCollectionViewCell.reuseId,
					for: indexPath
				) as? MainScreenCollectionViewCell else { return UICollectionViewCell()}
				cell.configure(model: item)
				return cell
			}
		)
	}
}

extension MainScreenViewController: MainScreenViewInput {
	func updateDataSource(models: [MainScreenItemModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<MainScreenSectionModel, MainScreenItemModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(models)
		dataSource?.apply(snapshot)
		collectionView.reloadData()
	}
}
