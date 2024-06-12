//
//  MainTabBarController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initialize()
        
        object_setClass(self.tabBar, CustomTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    func initialize() {
        self.tabBar.barTintColor = .orange
        self.tabBar.tintColor = .orange
        self.tabBar.unselectedItemTintColor = .black
        self.extendedLayoutIncludesOpaqueBars = true
        
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.06).cgColor
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.borderWidth = 0
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .black.withAlphaComponent(0.02)
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.selected.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        itemAppearance.normal.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12, weight: .regular)]
        
        
        itemAppearance.selected.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        itemAppearance.normal.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        viewControllers?.forEach {
            $0.tabBarItem.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.stackedLayoutAppearance = itemAppearance
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height = 64 + view.safeAreaInsets.bottom
        tabBar.frame.size.height = height
        
        // fix isu ios 13: https://stackoverflow.com/q/58641202/2537616
        //
        tabBar.subviews.forEach { (bar) in
            bar.subviews.compactMap {
                $0 as? UILabel
            }.forEach { buttonLabel in
                let labelFix = UILabel()
                labelFix.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
                labelFix.text = buttonLabel.text
                labelFix.sizeToFit()
                buttonLabel.frame.size.width = labelFix.frame.size.width
                buttonLabel.frame.size.height = labelFix.frame.size.height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        view.backgroundColor = .clear
        self.initialize()
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
        initialViewControllers()
    }
    
    func initialViewControllers() {

    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        item.badgeValue = nil
    }
}

// MARK: - COMPONENTS

extension MainTabBarController {
    
    class CustomTabBar: UITabBar {
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 88
            return sizeThatFits
        }
        
    }
    
}

