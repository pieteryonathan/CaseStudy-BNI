//
//  EmptyStateCustom.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import Foundation
import UIKit

class EmptyStateCustom: UITableViewCell {
    
    public lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageViewItem: UIImageView = {
        let imageViewX = UIImageView()
        imageViewX.backgroundColor = .clear
        imageViewX.contentMode = .scaleAspectFit
        imageViewX.translatesAutoresizingMaskIntoConstraints = false
        return imageViewX
    }()
    
    public lazy var labelTitle: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 18, weight: .semibold)
        labelX.textColor = .black
        labelX.numberOfLines = 0
        labelX.textAlignment = .center
        labelX.setContentHuggingPriority(.required, for: .vertical)
        return labelX
    }()
    
    private lazy var labelSubTitle: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 12)
        labelX.textColor = .black
        labelX.numberOfLines = 0
        labelX.textAlignment = .center
        labelX.setContentHuggingPriority(.required, for: .vertical)
        return labelX
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
        
        contentView.backgroundColor = .white
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: containerView, toView: contentView)
        
        containerView.addArrangedSubview(descView)
        descView.addArrangedSubview(imageViewItem)
        descView.addArrangedSubview(labelTitle)
        descView.addArrangedSubview(labelSubTitle)
        NSLayoutConstraint.activate([
            imageViewItem.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 242/360),
            imageViewItem.heightAnchor.constraint(equalTo: imageViewItem.widthAnchor, multiplier: 161/242),
            labelTitle.widthAnchor.constraint(equalTo: imageViewItem.widthAnchor)
        ])
        
        descView.setCustomSpacing(8, after: labelTitle)
    }
    
    // MARK: - DATA
    
    public func setData(image: UIImage, title: String, subTitle: String? = nil, spacing: CGFloat? = 24) {
        labelTitle.text = title
        if let subTitle = subTitle {
            labelSubTitle.isHidden = false
            labelSubTitle.text = subTitle
        } else {
            labelSubTitle.isHidden = true
        }
        imageViewItem.image = image
        descView.spacing = spacing ?? 24
    }
}
