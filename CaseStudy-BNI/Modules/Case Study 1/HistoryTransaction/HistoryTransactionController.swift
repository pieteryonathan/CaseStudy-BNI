//
//  HistoryTransactionController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

class HistoryTransactionController: UIViewController {

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
        label.text = "Transaction History"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TransactionHistoryCell.self, forCellReuseIdentifier: "TransactionHistoryCell")
        view.register(EmptyStateCustom.self, forCellReuseIdentifier: "EmptyStateCustom")
        return view
    }()
    
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
        containerView.addArrangedSubViews(views: [stackViewHeader ,tableView])
        stackViewHeader.addArrangedSubview(labelHeader)
    }
}

extension HistoryTransactionController: UITableViewDataSource, UITableViewDelegate {
        
    func getEmptyStateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCustom", for: indexPath) as! EmptyStateCustom
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.setData(image: UIImage(named: "ils_empty_state_transaction")!, title: "Nothing to show here", subTitle: "Start making transactions to see them")
        cell.containerView.heightAnchor.constraint(equalToConstant: tableView.frame.size.height).isActive = true
        return cell
    }
    
    func getHistoryCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryCell", for: indexPath) as! TransactionHistoryCell
        cell.setData(transactionHistory: Account.transactionHistory[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Account.transactionHistory.isEmpty ? 1 : Account.transactionHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return Account.transactionHistory.isEmpty ? getEmptyStateCell(indexPath) : getHistoryCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
