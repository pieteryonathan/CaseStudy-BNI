//
//  HeaderCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 17/06/24.
//

import Foundation
import UIKit

class HeaderCell: UITableViewCell {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 8, left: 24, bottom: 8, right: 24)
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
        label.text = "Portfolio"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    private lazy var stackTabBar: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonA: tabBarButton = {
        let buttonA = tabBarButton()
        buttonA.setData(title: "Details")
        buttonA.isSelected = true
        buttonA.addTapAction(self, action: #selector(buttonAPressed))
        return buttonA
    }()
    
    lazy var buttonB: tabBarButton = {
        let buttonB = tabBarButton()
        buttonB.setData(title: "Monthly")
        buttonB.isSelected = false
        buttonB.addTapAction(self, action: #selector(buttonBPressed))
        return buttonB
    }()
    
    // MARK: - VARIABLE DECLARAION
    var isSelectedA = true

    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    // MARK: - SETUP

    private func setupView() {
        backgroundColor = .clear
 
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: containerView, toView: contentView)
        containerView.addArrangedSubViews(views: [stackViewHeader, stackTabBar])
        stackViewHeader.addArrangedSubViews(views: [labelHeader, StackViewHelpers.getSpacerH()])
        stackTabBar.addArrangedSubViews(views: [buttonA, buttonB])
        
        buttonA.layer.cornerRadius = buttonA.frame.width / 2
        buttonB.layer.cornerRadius = buttonB.frame.width / 2
    }
    
    public func setData(title: String) {
        labelHeader.text = title
    }
    
    // MARK: - ACTION
    
    @objc func buttonAPressed(_ sender: Any) {
        guard !isSelectedA else {
            return
        }
        
        buttonA.isSelected.toggle()
        buttonB.isSelected.toggle()
        isSelectedA.toggle()
    }
    
    @objc func buttonBPressed(_ sender: Any) {
        guard isSelectedA else {
            return
        }
        buttonA.isSelected.toggle()
        buttonB.isSelected.toggle()
        isSelectedA.toggle()
    }
}

