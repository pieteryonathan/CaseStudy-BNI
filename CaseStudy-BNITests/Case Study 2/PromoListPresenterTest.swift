//
//  PromoListPresenterTest.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 15/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class MockSVProgressHUD {
    static var isShowErrorCalled = false
    static var errorMessage: String?

    static func show() {
        // Mock show method
    }

    static func dismiss() {
        // Mock dismiss method
    }

    static func showError(withStatus status: String?) {
        isShowErrorCalled = true
        errorMessage = status
    }

    static func reset() {
        isShowErrorCalled = false
        errorMessage = nil
    }
}

class PromoListPresenterTests: XCTestCase {
    
    var presenter: PromoListPresenter!
    var mockView: MockPromoListView!
    
    override func setUp() {
        super.setUp()
        presenter = PromoListPresenter()
        mockView = MockPromoListView()
        presenter.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        super.tearDown()
    }
    
    func testRefreshShowsLoading() {
        presenter.refresh()
        XCTAssertTrue(mockView.isLoadingShown)
    }
    
    func testRefreshFetchesPromosSuccess() {
        presenter.fetchPromos = { completion in
            let mockPromos: [Promo] = [Promo(id: 1, name: "BNI Mobile Banking", imagesUrl: "https://www.bni.co.id/Portals/1/BNI/Beranda/Images/Beranda-MobileBanking-01-M-Banking1.png", detail: "https://www.bni.co.id/id-id/individu/simulasi/bni-deposito"), Promo(id: 2, name: "BNI Wholesale", imagesUrl: "https://bit.ly/MarcommBNIFleksi-2023", detail: "https://www.bni.co.id/id-id/korporasi/solusi-wholesale/tentang-kami")]
            completion(.success(mockPromos))
        }
        
        presenter.refresh()
        
        XCTAssertTrue(mockView.isDataShown)
        XCTAssertEqual(presenter.promos.count, 2)
    }
    
    func testRefreshFetchesPromosFailure() {
        presenter.fetchPromos = { completion in
            let error = NSError(domain: "TestError", code: 1, userInfo: nil)
            completion(.failure(error))
        }
        
        presenter.refresh()
        
        XCTAssertTrue(mockView.isErrorShown)
    }
}

class MockPromoListView: PromoListProtocol {
    var isLoadingShown = false
    var isDataShown = false
    var isErrorShown = false
    var error: Error?
    
    func showLoading() {
        isLoadingShown = true
    }
    
    func showData() {
        isLoadingShown = false
        isDataShown = true
    }
    
    func showError(error: Error) {
        isLoadingShown = false
        isErrorShown = true
        self.error = error
    }
}

