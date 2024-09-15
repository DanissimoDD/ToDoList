//
//  MainScreenViewTests.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 15.09.2024.
//

import XCTest
@testable import ToDoList

final class MainScreenViewTests: XCTestCase {
	
	var sut: MainScreenViewController!
	var mockPresenter: MockMainScreenPresenter!

    override func setUp()  {
		super.setUp()
		mockPresenter = MockMainScreenPresenter()
		sut = MainScreenViewController(presenter: mockPresenter)
    }

    override func tearDown()  {
		sut = nil
		mockPresenter = nil
		super.tearDown()
    }
	
	
	
	func testViewDidLoad_CallsPresenterViewDidLoad() {
		// when
		sut.viewDidAppear(true)
		
		// then
		XCTAssertTrue(mockPresenter.viewDidLoadCalled)
	}
	
	func testUpdateDataSource_AppliesSnapshot() {
		// given
		let models = [MainScreenItemModel(title: "Task 1", subTitle: "Description 1", dateTime: Date(), hasDone: false)]
		
		// when
		sut.updateDataSource(models: models)
		guard let dataSource = sut.dataSource else { return }
		
		// then
		XCTAssertEqual(dataSource.snapshot().itemIdentifiers.count, 1)
	}

//	func testShowToast_DisplaysToastMessage() {
//		// when
//		sut.showToast(message: "Test Toast", duration: 2.0)
//		
//		// then
//		// Verify that the toast message is displayed on the screen
//		let toastViews = sut.view.subviews.filter { $0 is ToastView }
//		
//		// Check if there is exactly one ToastView
//		XCTAssertEqual(toastViews.count, 1, "Expected one ToastView to be displayed.")
//		
//		// Optionally, you can also check if the toast message is correct
//		if let toastView = toastViews.first as? ToastView {
//			XCTAssertEqual(toastView.toastLabel.text, "Test Toast", "Toast message should match the expected message.")
//		}
//	}
}
