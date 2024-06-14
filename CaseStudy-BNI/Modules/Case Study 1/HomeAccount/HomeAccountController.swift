//
//  HomeAccountController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class HomeAccountController: UIViewController {
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        return view
    }()
    
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = "Welcome, User!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    private lazy var stackViewOther: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelOtherCaseStudy: UILabel = {
        let label = UILabel()
        label.text = "Other Case Study"
        label.textColor = .orange
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.addTapAction(self, action: #selector(onOtherCaseStudyTapped))
        return label
    }()
    
    private lazy var stackViewCardAccount: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 24, left: 16, bottom: 24, right: 16)
        stackView.layer.cornerRadius = 8
        stackView.spacing = 24
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return stackView
    }()
    
    private lazy var labelBalance: UILabel = {
        let label = UILabel()
        label.text = "Balance"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var viewLineSpacer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var stackViewBalance: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelRp: UILabel = {
        let label = UILabel()
        label.text = "Rp"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var labelAmount: UILabel = {
        let label = UILabel()
        label.text = Account.getStringBalance()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var labelCardNumber: UILabel = {
        let label = UILabel()
        label.text = "Card Number"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var labelNumber: UILabel = {
        let label = UILabel()
        label.text = "123-456-789-101"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var viewSpacerBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    // MARK: - INIT
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        labelAmount.text = Account.getStringBalance()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        
        AccountManager.shared.paymentSuccessfull = {[unowned self] in
            labelAmount.text = Account.getStringBalance()
        }
    }
    
    func setupView() {
        containerView.addArrangedSubview(contentView)
        
        contentView.addArrangedSubViews(views: [stackViewHeader, stackViewCardAccount, stackViewOther, viewSpacerBottom])
        stackViewOther.addArrangedSubViews(views: [StackViewHelpers.getSpacerH(), labelOtherCaseStudy])
        stackViewHeader.addArrangedSubViews(views: [labelHeader, StackViewHelpers.getSpacerH()])
        stackViewCardAccount.addArrangedSubViews(views: [labelBalance, viewLineSpacer, stackViewBalance, labelCardNumber, labelNumber])
        stackViewCardAccount.setCustomSpacing(8, after: labelCardNumber)
        stackViewBalance.addArrangedSubViews(views: [labelRp, labelAmount])
    }
    
    // MARK: - ACTION
    
    @objc func onOtherCaseStudyTapped(_ sender: Any) {
        let controller = HomepageViewController()
        UIApplication.setRootView(controller)
    }
    
}
