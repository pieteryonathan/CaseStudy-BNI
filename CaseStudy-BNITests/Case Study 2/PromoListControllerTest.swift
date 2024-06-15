//
//  PromoListControllerTest.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 15/06/24.
//

import XCTest
import SVProgressHUD
@testable import CaseStudy_BNI

class MockPromoListPresenter: PromoListPresenter {
    var isRefreshCalled = false
    var mockPromos: [Promo] = []

    override func refresh() {
        isRefreshCalled = true
        self.promos = mockPromos
        self.view?.showData()
    }
}

class PromoListControllerTests: XCTestCase {

    var controller: PromoListController!
    var mockPresenter: MockPromoListPresenter!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        controller = PromoListController()
        mockPresenter = MockPromoListPresenter()
        controller.presenter = mockPresenter
        window.addSubview(controller.view)
        RunLoop.current.run(until: Date()) // Allows the view to load
    }

    override func tearDown() {
        controller = nil
        mockPresenter = nil
        window = nil
        super.tearDown()
    }

    func testViewDidLoadCallsRefresh() {
        controller.viewDidLoad()
        XCTAssertTrue(mockPresenter.isRefreshCalled)
    }

    func testShowLoading() {
        controller.showLoading()
        XCTAssertTrue(controller.isLoading)
        XCTAssertFalse(controller.viewLoading.isHidden)
        XCTAssertTrue(controller.tableViewPromo.isHidden)
    }

    func testShowData() {
        MockSVProgressHUD.reset()
        
        controller.showData()
        
        XCTAssertFalse(controller.isDefault)
    }

    func testShowError() {
        MockSVProgressHUD.reset()
        
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test Error Message"])
        controller.showError(error: error)
        
        XCTAssertTrue(controller.isError)
    }

    func testTableViewDataSource() {
        mockPresenter.mockPromos = [
            Promo(id: 1, name: "BNI Mobile Banking", imagesUrl: "https://www.bni.co.id/Portals/1/BNI/Beranda/Images/Beranda-MobileBanking-01-M-Banking1.png", detail: "https://www.bni.co.id/id-id/individu/simulasi/bni-deposito"),
            Promo(id: 2, name: "BNI Wholesale", imagesUrl: "https://bit.ly/MarcommBNIFleksi-2023", detail: "https://www.bni.co.id/id-id/korporasi/solusi-wholesale/tentang-kami")
        ]
        controller.presenter.refresh()
                
        controller.tableViewPromo.reloadData()

        XCTAssertEqual(controller.tableViewPromo.numberOfRows(inSection: 0), 2)
    }

    func testEmptyState() {
        mockPresenter.mockPromos = []
        controller.showData()
        
        let tableView = controller.tableViewPromo
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        let cell = controller.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? EmptyStateCustom
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.labelTitle.text, "There is no promo")
    }
}
