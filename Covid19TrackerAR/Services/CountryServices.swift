//
//  CountryServices.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

class CountryServices {
    
    let networkServicesAPI = NetworkServices()
    
    func fetchCountriesInfo(completion: @escaping ([CountryModel]) -> ()) {
        networkServicesAPI.loadCountries(classType: [CountryModel].self) { (result) in
            if let countries = result {
                completion(countries)
            } else {
                completion([CountryModel]())
            }
        }
    }
}
