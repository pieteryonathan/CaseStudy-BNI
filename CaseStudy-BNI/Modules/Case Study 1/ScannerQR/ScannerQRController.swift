//
//  ScannerQRController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class ScannerQRController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let qrScanner = QRScannerController()
        qrScanner.modalPresentationStyle = .pageSheet // Set the desired presentation style
        present(qrScanner, animated: true, completion: nil)
    }
}
