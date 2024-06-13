//
//  Account.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import Foundation
import SVProgressHUD

public class Account {
    
    static var balance: Int = 100000
    static var transactionHistory: [TransactionHistory] = [] { didSet {
        AccountManager.shared.transactionHistoryDidChange?()
    }}
    
    static func deposit(amount: Int) {
        balance += amount
    }
    
    static func withdraw(amount: Int, completion: @escaping (Bool) -> Void) {
        if amount <= balance {
            balance -= amount
            completion(true)
        } else {
            completion(false)
        }
    }
    
    static func getStringBalance() -> String {
        return FormattingHelper.addPeriods(to: Account.balance)
    }
}

class AccountManager {
    static let shared = AccountManager()
    
    var paymentSuccessfull: (() -> Void)?
    
    var transactionHistoryDidChange: (() -> Void)?
}
