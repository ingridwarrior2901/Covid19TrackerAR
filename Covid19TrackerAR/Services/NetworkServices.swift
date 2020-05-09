//
//  NetworkService.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import UIKit

struct NetworkServices {
    
    private struct Constants {
        static let BaseURL = "https://corona.lmao.ninja/v2/countries"
    }
    
    func loadCountries<T: Decodable>(classType: T.Type, completion: @escaping (T?) -> ()) {
        guard let URL = URL(string: Constants.BaseURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            guard let resultData = data else {
                completion(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: resultData)
                completion(result)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func loadImage(imageURL: String, completion: @escaping (Data?) -> ()) {
        guard let URL = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            guard let resultData = data else {
                completion(nil)
                return
            }
           completion(resultData)
        }.resume()
    }
}
