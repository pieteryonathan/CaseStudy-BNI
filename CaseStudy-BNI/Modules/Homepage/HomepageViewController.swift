//
//  HomepageViewController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class HomepageViewController: UIViewController {
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.backgroundColor = .white
        view.spacing = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewSpacerTop: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    private lazy var buttonCaseStudy1: PrimaryButton = {
        let buttonX = PrimaryButton()
        buttonX.setData(title: "Case Study 1", buttonColor: .orange)
        buttonX.addTapAction(self, action: #selector(onCaseStudy1Tapped))
        return buttonX
    }()
    
    private lazy var buttonCaseStudy2: PrimaryButton = {
        let buttonX = PrimaryButton()
        buttonX.setData(title: "Case Study 2", buttonColor: .orange)
        buttonX.addTapAction(self, action: #selector(onCaseStudy2Tapped))
        return buttonX
    }()
    
    private lazy var buttonCaseStudy3: PrimaryButton = {
        let buttonX = PrimaryButton()
        buttonX.setData(title: "Case Study 3", buttonColor: .orange)
        return buttonX
    }()
    
    private lazy var viewSpacerBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        containerView.addArrangedSubViews(views: [viewSpacerTop, buttonCaseStudy1, buttonCaseStudy2, buttonCaseStudy3, viewSpacerBottom])
        
        viewSpacerTop.heightAnchor.constraint(equalTo: viewSpacerBottom.heightAnchor).isActive = true
    }
    
    // MARK: - ACTION
    
    @objc private func onCaseStudy1Tapped(_ sender: Any) {
        let controller = MainTabCaseStudy1Controller()
        UIApplication.setRootView(controller)
    }
    
    @objc private func onCaseStudy2Tapped(_ sender: Any) {
        let promoListController = PromoListController()
        let navigationController = UINavigationController(rootViewController: promoListController)
        UIApplication.setRootView(navigationController)
    }
}
