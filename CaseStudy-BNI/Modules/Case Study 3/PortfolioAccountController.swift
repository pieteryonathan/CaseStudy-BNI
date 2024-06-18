//
//  PortfolioAccountController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 17/06/24.
//

import Foundation
import UIKit

class PortfolioAccountController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case chart = 1
        case history = 2
    }

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        self.view.addSubview(view)
        NSLayoutConstraint.pinToView(view, toView: self.view, edges: [.bottom])
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view, edges: [.top, .left, .right])
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        view.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        view.register(HeaderCategoryCell.self, forCellReuseIdentifier: "HeaderCategoryCell")
        view.register(PieChartCell.self, forCellReuseIdentifier: "PieChartCell")
        view.register(LineChartCell.self, forCellReuseIdentifier: "LineChartCell")
        return view
    }()
    
    // MARK: - VARIABLE DECLARATOIN
    var presenter = PortfolioAccountPresenter()
    var isSelectedDetails = true { didSet {
        tableView.reloadData()
    }}
    
    // MARK: - OVERRIDE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        setupView()
        AccountManager.shared.transactionHistoryDidChange = {[unowned self] in
            tableView.reloadData()
        }
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [tableView])
    }
}

extension PortfolioAccountController: UITableViewDataSource, UITableViewDelegate {
        
    func getHeaderCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
        cell.onValueChange = {[unowned self] isSelectedA in
            self.isSelectedDetails = isSelectedA
        }
        cell.setData(title: "Portfolio")
        cell.selectionStyle = .none
        return cell
    }
    
    func getPieChartCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PieChartCell", for: indexPath) as! PieChartCell
        cell.setData(pieDatas: presenter.getDataPieChart())
        cell.onChartTapped = {[unowned self] labelValue in
            let chartData = presenter.donutChartData.first { $0.label == labelValue }
            
            if let chartData = chartData {
                let detailTransaction = DetailTransactionController()
                detailTransaction.setData(dataTransaction: chartData)
                navigationController?.pushViewController(detailTransaction, animated: true)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func getLineChartCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineChartCell", for: indexPath) as! LineChartCell
        cell.selectionStyle = .none
        cell.setData(chartData: presenter.getLineChartData())
        return cell
    }
    
    func getHeaderCategoryCell(_ indexPath: IndexPath, categoryIndex: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCategoryCell", for: indexPath) as! HeaderCategoryCell
        cell.setTitle(presenter.donutChartData[categoryIndex].label)
        cell.selectionStyle = .none
        return cell
    }

    func getHistoryCell(_ indexPath: IndexPath, transactionIndex: Int?) -> UITableViewCell {
        guard let transactionIndex = transactionIndex else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        let (categoryIndex, _) = presenter.transactionIndexForRow(indexPath.row)!
        let data = presenter.donutChartData[categoryIndex].data[transactionIndex]
        cell.setData(transaction: data)
        cell.selectionStyle = .none
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = Section(rawValue: section)!
        switch item {
        case .header:
            return 1
        case .chart:
            return 1
        case .history:
            return presenter.getNumberRowInSection()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = Section(rawValue: indexPath.section)!
        switch item {
        case .header:
            return getHeaderCell(indexPath)
        case .chart:
            if isSelectedDetails {
                return getPieChartCell(indexPath)
            } else {
                return getLineChartCell(indexPath)
            }
        case .history:
            if let (categoryIndex, transactionIndex) = presenter.transactionIndexForRow(indexPath.row) {
                if transactionIndex == -1 {
                    return getHeaderCategoryCell(indexPath, categoryIndex: categoryIndex)
                } else {
                    return getHistoryCell(indexPath, transactionIndex: transactionIndex)
                }
            } else {
                fatalError("Invalid row index \(indexPath.row) in history section")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
