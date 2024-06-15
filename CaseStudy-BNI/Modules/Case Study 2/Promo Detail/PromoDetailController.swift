//
//  PromoDetailController.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import UIKit
import WebKit
import SVProgressHUD

class PromoDetailController: UIViewController {
    
    lazy var safeView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        self.view.addSubview(view)
        NSLayoutConstraint.pinToView(view, toView: self.view, edges: [.bottom])
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view, edges: [.top, .left, .right])
        return view
    }()
    
    lazy var navBar: NavbarBackTitle = {
        let navBar = NavbarBackTitle(self)
        navBar.setTitle(title: promo.name)
        return navBar
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - VARIABLE DECLARATION
    var promo: Promo
    
    // MARK: - INIT
    init(promo: Promo) {
        self.promo = promo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        setState()
        setupView()
        
        loadWebView()
    }
    
    // MARK: SETUP VIEW
    func setupView() {
        safeView.addArrangedSubViews(views: [navBar, webView])
    }
    
    // MARK: LOAD WEBVIEW
    func loadWebView() {
        // Example URL to load (replace with your actual URL)
        if let url = URL(string: promo.detail) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func setState() {
        // Customize state if needed
    }
}
