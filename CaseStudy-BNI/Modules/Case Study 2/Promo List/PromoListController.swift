//
//  PromoListController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import UIKit
import SVProgressHUD

class PromoListController: UIViewController {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    private lazy var stackViewHeader: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        return view
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = "Promo List"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    private lazy var viewLoading: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PromoCell.self, forCellReuseIdentifier: "PromoCell")
        view.register(EmptyStateCustom.self, forCellReuseIdentifier: "EmptyStateCustom")
        return view
    }()
    
    // MARK: - VARIABLE DECLARATION
    let presenter = PromoListPresenter()
    var isLoading = true { didSet {
        setStateLoading()
    }}
    
    // MARK: - OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading = true
        view.backgroundColor = .white
        setupView()
        presenter.view = self
        presenter.refresh()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [stackViewHeader, viewLoading ,tableView])
        stackViewHeader.addArrangedSubview(labelHeader)
    }
    
    private func setStateLoading() {
        viewLoading.isHidden = !isLoading
        tableView.isHidden = isLoading
    }
}

extension PromoListController: UITableViewDataSource, UITableViewDelegate {
        
    func getEmptyStateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCustom", for: indexPath) as! EmptyStateCustom
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.setData(image: UIImage(named: "ils_empty_state_transaction")!, title: "There is no promo", subTitle: "Waiting for the next promo")
        cell.containerView.heightAnchor.constraint(equalToConstant: tableView.frame.size.height).isActive = true
        return cell
    }
    
    func getPromoCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCell", for: indexPath) as! PromoCell
        cell.selectionStyle = .none
        cell.setData(image: UIImage(named: "ils_empty_promo")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.promos.isEmpty ? 1 : presenter.promos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.promos.isEmpty ? getEmptyStateCell(indexPath) : getPromoCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension PromoListController: PromoListProtocol {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func showData() {
        SVProgressHUD.dismiss()
        DispatchQueue.main.async { [unowned self] in
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
    
    func showError(error: any Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
}
