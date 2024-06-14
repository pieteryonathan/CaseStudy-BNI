//
//  PaymentCompletionController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import UIKit

class PaymentCompletionController: UIViewController {

    lazy var safeView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 0, left: 24, bottom: 0, right: 24)
        return view
    }()
    
    lazy var viewTopSpace: UIView = {
        let viewSpace = UIView()
        return viewSpace
    }()
    
    lazy var imageViewIls: UIImageView = {
        let imageViewIls = UIImageView()
        imageViewIls.image = UIImage(named: "ils_payment_successful")
        imageViewIls.contentMode = .scaleAspectFit
        imageViewIls.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageViewIls.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageViewIls.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return imageViewIls
    }()
    
    lazy var labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = .systemFont(ofSize: 18, weight: .bold)
        labelTitle.textColor = .black
        labelTitle.textAlignment = .center
        labelTitle.text = "Payment Successful!"
        return labelTitle
    }()
    
    lazy var labelSubTitle: UILabel = {
        let labelSubTitle = UILabel()
        labelSubTitle.font = .systemFont(ofSize: 12, weight: .regular)
        labelSubTitle.textColor = .black
        labelSubTitle.textAlignment = .center
        labelSubTitle.numberOfLines = 0
        labelSubTitle.lineBreakMode = .byWordWrapping
        labelSubTitle.text = "You have completed your payment."
        return labelSubTitle
    }()
    
    lazy var viewBottomSpace: UIView = {
        let viewSpace = UIView()
        viewSpace.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return viewSpace
    }()
    
    lazy var buttonA: PrimaryButton = {
        let buttonA = PrimaryButton()
        buttonA.setData(title: "Go to history", buttonColor: .orange)
        buttonA.addTapAction(self, action: #selector(buttonAPressed))
        return buttonA
    }()
    
    lazy var buttonB: PrimaryButton = {
        let buttonB = PrimaryButton()
        buttonB.setData(title: "Back to home", buttonColor: .clear, textColor: .orange)
        buttonB.addTapAction(self, action: #selector(buttonBPressed))
        return buttonB
    }()
    
    // MARK: - VARIABLE DECLARATION
    var isbuttonProcessing = false

    // MARK: - OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        
        safeView.addArrangedSubview(contentView)
        contentView.addArrangedSubViews(views: [viewTopSpace, imageViewIls, labelTitle, labelSubTitle, viewBottomSpace, buttonA, buttonB])
        contentView.setCustomSpacing(0, after: imageViewIls)
        contentView.setCustomSpacing(8, after: labelTitle)
        viewTopSpace.heightAnchor.constraint(equalTo: viewBottomSpace.heightAnchor).isActive = true

    }
        
    // MARK: - ACTION
    
    @objc func buttonAPressed(_ sender: UIButton) {
        guard !isbuttonProcessing else {
               return // Ignore tap if button is already in progress
           }
           
        isbuttonProcessing = true
        
        self.dismissAllViewControllers()
        if let tabViewController = UIApplication.shared.windows.first?.rootViewController as? MainTabCaseStudy1Controller {
            tabViewController.selectedIndex = 2 // Show History
        }
        
    }
    @objc func buttonBPressed(_ sender: UIButton) {
        guard !isbuttonProcessing else {
               return // Ignore tap if payment is already in progress
           }
           
        isbuttonProcessing = true
        self.dismissAllViewControllers()
        if let tabViewController = UIApplication.shared.windows.first?.rootViewController as? MainTabCaseStudy1Controller {
            tabViewController.selectedIndex = 0 // Show Home
        }
    }
}
