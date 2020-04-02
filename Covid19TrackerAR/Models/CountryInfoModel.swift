//
//  CountryInfoModel.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

struct CountryInfoModel: Decodable {
    var id: Int
    var iso2: String
    var iso3: String
    var lat: Double
    var long: Double
    var flag: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case iso2
        case iso3
        case lat
        case long
        case flag
    }
    
    init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        id = try decode.decodeIfPresent(Int.self, forKey: .id) ?? 0
        iso2 = try decode.decodeIfPresent(String.self, forKey: .iso2) ?? ""
        iso3 = try decode.decodeIfPresent(String.self, forKey: .iso3) ?? ""
        lat = try decode.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        long = try decode.decodeIfPresent(Double.self, forKey: .long) ?? 0
        flag = try decode.decodeIfPresent(String.self, forKey: .flag) ?? ""
    }
}
