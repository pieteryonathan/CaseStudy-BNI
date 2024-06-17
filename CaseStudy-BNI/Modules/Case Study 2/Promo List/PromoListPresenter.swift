//
//  PromoListPresenter.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import Foundation
import UIKit
import Alamofire

protocol PromoListProtocol {
    func showLoading()
    func showData()
    func showError(error: Error)
}

class PromoListPresenter {
    
    var promos: [Promo] = []
    var view: PromoListProtocol?
    var posters: [String] = ["img_banner_promo_1", "img_banner_promo_2"]
    
    // Closure property for dependency injection
    var fetchPromos: (@escaping (Result<[Promo], Error>) -> Void) -> Void = { completion in
        let urlString = "http://demo5853970.mockable.io/promos"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InvalidURL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbbUdsYSaLutOWni88ZBs9S8"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, headers: headers).validate().responseDecodable(of: PromoResponse.self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let promoResponse):
                print("Successfully fetched promos")
                completion(.success(promoResponse.promos))
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func refresh() {
        self.view?.showLoading()
        promos.removeAll()
        fetchPromos {[unowned self] result in
            switch result {
            case .success(let promos):
                self.promos = promos
                DispatchQueue.main.async {
                    self.view?.showData()
                }
            case .failure(let failure):
                print("Failed to fetch promos: \(failure.localizedDescription)")
                DispatchQueue.main.async {
                    self.view?.showError(error: failure)
                }
            }
        }
    }
}
