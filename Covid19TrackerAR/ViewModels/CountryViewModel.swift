//
//  CountryViewModel.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol CountryViewModelProtocol {
    var countryName: String { get }
    var countryImageFlag: String { get }
    var countryCases: String { get }
    var countryDeaths: String { get }
    var countryRecovered: String { get }
    var countryActive: String { get }
}

class CountryViewModel: CountryViewModelProtocol  {
    
    //MARK: - Properties
    var countryName: String
    var countryImageFlag: String
    var countryCases: String
    var countryDeaths: String
    var countryRecovered: String
    var countryActive: String
    
    let networkServicesAPI = NetworkServices()
    
    init(model: CountryModel) {
        countryName = model.country
        countryImageFlag = model.countryInfo?.flag ?? ""
        countryCases = "\(model.cases)"
        countryDeaths = "\(model.deaths)"
        countryRecovered = "\(model.recovered)"
        countryActive = "\(model.active)"
    }
    
    static func countryModelTransformer(countries: [CountryModel]) -> [CountryViewModel] {
        return countries.map { CountryViewModel(model: $0) }
    }
    
    //MARK: - Public Methods
    func loadCountryImage(completion: @escaping (UIImage?) -> ()) {
        if !countryImageFlag.isEmpty {
            networkServicesAPI.loadImage(imageURL: countryImageFlag) {(data) in
                guard let resultData = data else {
                    completion(nil)
                    return
                }
                completion(UIImage(data: resultData))
            }
        }
    }
}
