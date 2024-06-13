//
//  PaymentConfirmationController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit
import SVProgressHUD

class PaymentConfirmationController: UIViewController {
    
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
    
    lazy var navBar: NavbarBacknClose = {
        let navBar = NavbarBacknClose(self)
        navBar.containerView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        return navBar
    }()
  
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = "QR Payment"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    private func viewSpaceRight() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }
    
    private lazy var stackViewCardAccount: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 24, right: 16)
        stackView.layer.cornerRadius = 8
        stackView.spacing = 0
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return stackView
    }()
    
    private lazy var stackViewHIdTranscation: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewVIdTranscation: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelTitleIdTransaction: UILabel = {
        let label = UILabel()
        label.text = "Transaction Id"
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var labelIdTransaction: UILabel = {
        let label = UILabel()
        label.text = "ID12345678"
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var labelFromAcount: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var labelNoAccount: UILabel = {
        let label = UILabel()
        label.text = "123-456-789-101"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var stackViewHLineSpacer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 4, bottom: 0, right: 0)
        return stackView
    }()
    
    private lazy var viewLineSpacer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var labelToAcount: UILabel = {
        let label = UILabel()
        label.text = "BNI"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var labelNameMerchant: UILabel = {
        let label = UILabel()
        label.text = "MERCHANT MOCK TEST"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var labelTotal: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var stackViewBalance: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewVTotal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelRp: UILabel = {
        let label = UILabel()
        label.text = "Rp "
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var labelAmount: UILabel = {
        let label = UILabel()
        label.text = "1.000.000"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var viewSpacerBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var buttonPay: PrimaryButton = {
        let buttonX = PrimaryButton()
        buttonX.setData(title: "Pay", buttonColor: .orange)
        buttonX.addTapAction(self, action: #selector(onPayTapped))
        return buttonX
    }()
    
    // MARK: - VARIABLE DECLARATION
    private var paymentConfirmation: PaymentConfirmation
    private var isPaymentProcessing = false
    
    // MARK: - INIT
    init(paymentConfirmation: PaymentConfirmation) {
        self.paymentConfirmation = paymentConfirmation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDE
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setupView()
        setState()
    }
    
    private func setupView() {
        containerView.addArrangedSubview(contentView)
        
        contentView.addArrangedSubViews(views: [navBar, stackViewHeader, stackViewCardAccount, viewSpacerBottom, buttonPay])
        stackViewHeader.addArrangedSubViews(views: [labelHeader, viewSpaceRight()])
        
        stackViewCardAccount.addArrangedSubViews(views: [stackViewHIdTranscation, labelFromAcount, labelNoAccount ,stackViewHLineSpacer, labelToAcount, labelNameMerchant, stackViewVTotal])
        
        stackViewHIdTranscation.addArrangedSubViews(views: [StackViewHelpers.getSpacerH(), stackViewVIdTranscation])
        stackViewVIdTranscation.addArrangedSubViews(views: [labelTitleIdTransaction, labelIdTransaction])
        stackViewHLineSpacer.addArrangedSubViews(views: [viewLineSpacer, StackViewHelpers.getSpacerH()])
        stackViewVTotal.addArrangedSubViews(views: [labelTotal ,stackViewBalance])
        stackViewBalance.addArrangedSubViews(views: [labelRp, labelAmount])
        
        stackViewCardAccount.setCustomSpacing(32, after: labelNameMerchant)
    }
    
    // MARK: - STATE
    private func setState() {
        labelToAcount.text = paymentConfirmation.nameBank
        labelNameMerchant.text = paymentConfirmation.nameOfMerchant
        labelAmount.text = FormattingHelper.addPeriods(to: paymentConfirmation.totalOfTransaction ?? 0)
        labelIdTransaction.text = paymentConfirmation.idPayment
    }
    
    // MARK: - ACTION
    
    @objc private func onPayTapped(_ sender: Any) {
        guard !isPaymentProcessing else {
               return // Ignore tap if payment is already in progress
           }
           
           isPaymentProcessing = true
        
        SVProgressHUD.show()
        Account.withdraw(amount: paymentConfirmation.totalOfTransaction ?? 0) { success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
                    AccountManager.shared.paymentSuccessfull?()
                    Account.transactionHistory.append(TransactionHistory(merchant: paymentConfirmation.nameOfMerchant ?? "", total: paymentConfirmation.totalOfTransaction ?? 0))
                    SVProgressHUD.dismiss()
                    let controller = PaymentCompletionController()
                    controller.pushReplace(on: self)
                }
            } else {
                SVProgressHUD.showError(withStatus: "Unable to complete payment. Your balance is too low")
            }
        }
        
    }
    
    @objc private func onBackTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
