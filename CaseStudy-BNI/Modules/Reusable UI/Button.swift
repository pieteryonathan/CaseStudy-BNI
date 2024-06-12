//
//  Button.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class PrimaryButton: UIView {

    private lazy var containerView: UIStackView = {
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
    
    private lazy var labelTitle: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 16, weight: .bold)
        labelX.textAlignment = .center
        labelX.numberOfLines = 0
        labelX.lineBreakMode = .byWordWrapping
        labelX.textColor = .white
        labelX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return labelX
    }()
    
    // MARK: - VARIABLE DECLARATION
        
    private var buttonColor: UIColor = .orange { didSet {
        setState()
    }}
    
    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }
    
    private func setState() {
        containerView.backgroundColor = buttonColor
    }
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [labelTitle])
    }
    
    public func setData(title: String, buttonColor: UIColor, textColor: UIColor? = .white) {
        labelTitle.text = title
        labelTitle.textColor = textColor
        self.buttonColor = buttonColor
    }
}
