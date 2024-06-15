//
//  PromoListPresenter.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import Foundation
import UIKit

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
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Assuming Bearer token scheme
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let promoResponse = try decoder.decode(PromoResponse.self, from: data)
                completion(.success(promoResponse.promos))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func refresh() {
        self.view?.showLoading()
        promos.removeAll()
        fetchPromos {[unowned self] result in
            switch result {
            case .success(let promos):
                self.promos = promos
                self.view?.showData()
            case .failure(let failure):
                self.view?.showError(error: failure)
            }
        }
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InvalidURL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                let error = NSError(domain: "ImageConversion", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
