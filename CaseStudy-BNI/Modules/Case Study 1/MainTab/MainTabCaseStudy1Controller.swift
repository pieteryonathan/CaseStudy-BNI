//
//  MainTabController.swift
//  nebengers-ios
//
//  Created by Pieter Yonathan on 19/09/23.
//  Copyright © 2023 Rifat Firdaus. All rights reserved.
//

import Foundation
import UIKit

class MainTabCaseStudy1Controller: MainTabBarController {
    
    private lazy var imageViewScanQR: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_scan_qr")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageViewAddTrip.addTapAction(self, action: #selector(onTapAddTrip))
        return imageView
    }()
     
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        imageViewScanQR.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
        imageViewScanQR.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 16).isActive = true
        imageViewScanQR.widthAnchor.constraint(equalToConstant: 72).isActive = true
        imageViewScanQR.heightAnchor.constraint(equalToConstant: 88).isActive = true
        imageViewScanQR.layer.zPosition = 100
        
        self.tabBar.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(imageViewScanQR)
        
        NotificationCenter.default.addObserver(self, selector: #selector(scanQR(_:)), name: Notification.Name("scanQR"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func scanQR(_ sender: Any) {
//        let controller = CreateNewTripController()
//        controller.embedInNav().showModal(on: self)
    }
    
    // MARK: - Declaration Menu
    lazy var homeViewController: HomeAccountController = {
        let controller = HomeAccountController()
        controller.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        if let image = UIImage(systemName: "house.fill") {
            let coloredImage = image.withTintColor(.orange)
            controller.tabBarItem.selectedImage = coloredImage
        }
        return controller
    }()
    
    lazy var scanQRController: ScannerQRController = {
        let controller = ScannerQRController()
        controller.tabBarItem = UITabBarItem(title: "", image: nil, tag: 1)
        return controller
    }()
    
    lazy var historyTransactionController: HistoryTransactionController = {
        let controller = HistoryTransactionController()
        controller.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "newspaper"), tag: 2)
        if let image = UIImage(systemName: "newspaper.fill") {
            let coloredImage = image.withTintColor(.orange)
            controller.tabBarItem.selectedImage = coloredImage
        }
        return controller
    }()
    
   
    override func initialViewControllers() {
        viewControllers = [
            homeViewController,
            scanQRController,
            historyTransactionController
        ]
    }
}
