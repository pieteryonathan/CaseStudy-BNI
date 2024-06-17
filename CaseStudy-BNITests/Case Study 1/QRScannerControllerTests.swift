//
//  QRScannerControllerTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 17/06/24.
//

import XCTest
@testable import CaseStudy_BNI
import AVFoundation

class QRScannerControllerTests: XCTestCase {

    var qrScannerController: QRScannerController!

    override func setUpWithError() throws {
        qrScannerController = QRScannerController()
        qrScannerController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        qrScannerController = nil
    }

    func testQRCodeDetection() throws {
        let sampleQRCode = "BankName.12345.MerchantName.67890"
        let components = sampleQRCode.components(separatedBy: ".")

        XCTAssertEqual(components.count, 4, "The QR code does not have the expected format.")

        let nameBank = components[0].trimmingCharacters(in: .whitespaces)
        let idPayment = components[1].trimmingCharacters(in: .whitespaces)
        let nameOfMerchant = components[2].trimmingCharacters(in: .whitespaces)
        let totalOfTransaction = components[3].trimmingCharacters(in: .whitespaces)

        XCTAssertEqual(nameBank, "BankName")
        XCTAssertEqual(idPayment, "12345")
        XCTAssertEqual(nameOfMerchant, "MerchantName")
        XCTAssertEqual(totalOfTransaction, "67890")
    }
}
