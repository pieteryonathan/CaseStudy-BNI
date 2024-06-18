//
//  DetailTransactionController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 18/06/24.
//

import Foundation
import UIKit

class DetailTransactionController: UIViewController {

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
    
    lazy var navBar: NavbarBackTitle = {
        let navBar = NavbarBackTitle(self)
        return navBar
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        view.register(EmptyStateCustom.self, forCellReuseIdentifier: "EmptyStateCustom")
        return view
    }()
    
    // MARK: - VARIABLE DECLARATION
    var dataTransaction: DonutChartData?
    
    // MARK: - OVERRIDE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        AccountManager.shared.transactionHistoryDidChange = {[unowned self] in
            tableView.reloadData()
        }
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [navBar ,tableView])
    }
    
    func setData(dataTransaction: DonutChartData) {
        self.dataTransaction = dataTransaction
        navBar.setTitle(title: dataTransaction.label)
        tableView.reloadData()
    }
}

extension DetailTransactionController: UITableViewDataSource, UITableViewDelegate {
        
    func getEmptyStateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCustom", for: indexPath) as! EmptyStateCustom
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.setData(image: UIImage(named: "ils_empty_state_transaction")!, title: "Nothing to show here", subTitle: "Start making transactions to see them")
        cell.containerView.heightAnchor.constraint(equalToConstant: tableView.frame.size.height).isActive = true
        return cell
    }
    
    func getHistoryCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        if let transaction = dataTransaction?.data[indexPath.row] {
            cell.setData(transaction: transaction)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTransaction?.data.isEmpty ?? false ? 1 : dataTransaction?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataTransaction?.data.isEmpty ?? false ? getEmptyStateCell(indexPath) : getHistoryCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
