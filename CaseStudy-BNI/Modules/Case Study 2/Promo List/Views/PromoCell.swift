//
//  PromoCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import Foundation
import UIKit

class PromoCell: UITableViewCell {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 16, left: 24, bottom: 16, right: 24)
        return view
    }()

    private lazy var stackViewContent: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    private lazy var imageViewPromo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return imageView
    }()

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
        containerView.addArrangedSubview(stackViewContent)
        stackViewContent.addArrangedSubview(imageViewPromo)
    }
    
    public func setData(image: UIImage) {
        imageViewPromo.image = image
    }
}
