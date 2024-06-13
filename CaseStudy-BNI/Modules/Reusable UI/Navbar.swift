//
//  Navbar.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import UIKit

class NavbarBack: UIView {

    lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 16
        view.insetsLayoutMarginsFromSafeArea = false
        view.layer.cornerRadius = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        self.addSubview(view)
        NSLayoutConstraint.pinToView(view, toView: self)
        return view
    }()
    
    lazy var stackViewNavBar: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageViewBack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.backward.circle.fill")
        imageView.tintColor = .orange
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.addTapAction(self, action: #selector(onBackTapped))
        return imageView
    }()
    
    // MARK: - VARIABLE DECLARATION
    
    var controller: UIViewController
        
    init(_ controller: UIViewController) {
        self.controller = controller
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        containerView.addArrangedSubViews(views: [stackViewNavBar])
        stackViewNavBar.addArrangedSubViews(views: [imageViewBack, StackViewHelpers.getSpacerH()])
    }
    
    @objc private func onBackTapped(_ sender: Any) {
        controller.popOrDismiss(animated: true)
    }
    
    func dismissAllViewControllers() {
        var presentingViewController = controller.presentingViewController
        while presentingViewController?.presentingViewController != nil {
            presentingViewController = presentingViewController?.presentingViewController
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

class NavbarClose: NavbarBack {
    
    override func setupView() {
        imageViewBack.image = UIImage(systemName: "x.circle.fill")
        imageViewBack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageViewBack.widthAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.addArrangedSubViews(views: [stackViewNavBar])
        stackViewNavBar.addArrangedSubViews(views: [StackViewHelpers.getSpacerH(), imageViewBack])
    }
}

class NavbarBacknClose: NavbarBack {
    
    lazy var imageViewClose: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "x.circle.fill")
        imageView.tintColor = .orange
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.addTapAction(self, action: #selector(onCloseTapped))
        return imageView
    }()
    
    override func setupView() {
        containerView.addArrangedSubViews(views: [stackViewNavBar])
        stackViewNavBar.addArrangedSubViews(views: [imageViewBack, StackViewHelpers.getSpacerH(), imageViewClose])
    }
    
    @objc private func onCloseTapped(_ sender: Any) {
        self.dismissAllViewControllers()
    }
}
