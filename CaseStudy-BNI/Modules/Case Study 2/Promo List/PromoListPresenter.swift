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
    
    func fetchPromos(completion: @escaping (Result<[Promo], Error>) -> Void) {
        let urlString = "http://demo5853970.mockable.io/promos"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Ensure there is data
            guard let data = data else {
                print("No data received")
                let error = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Decode the JSON
            do {
                let decoder = JSONDecoder()
                let promoResponse = try decoder.decode(PromoResponse.self, from: data)
                completion(.success(promoResponse.promos))
            } catch {
                print("JSON Decoding Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Ensure there is data
            guard let data = data else {
                print("No data received")
                let error = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Convert data to UIImage
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                print("Failed to convert data to image")
                let error = NSError(domain: "ImageConversion", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
