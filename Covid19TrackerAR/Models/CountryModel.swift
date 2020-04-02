//
//  ContryModel.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

struct CountryModel: Decodable {
    var country: String
    var cases: Int
    var casesPerOneMillion: Double
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
    var deathsPerOneMillion: Double
    var updated: TimeInterval
    var countryInfo: CountryInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case country
        case cases
        case casesPerOneMillion
        case todayCases
        case deaths
        case todayDeaths
        case recovered
        case active
        case critical
        case deathsPerOneMillion
        case updated
        case countryInfo
    }
    
    init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        country = try decode.decodeIfPresent(String.self, forKey: .country) ?? ""
        cases = try decode.decodeIfPresent(Int.self, forKey: .cases) ?? 0
        casesPerOneMillion = try decode.decodeIfPresent(Double.self, forKey: .casesPerOneMillion) ?? 0.0
        todayCases = try decode.decodeIfPresent(Int.self, forKey: .todayCases) ?? 0
        deaths = try decode.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
        todayDeaths = try decode.decodeIfPresent(Int.self, forKey: .todayDeaths) ?? 0
        recovered = try decode.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
        active = try decode.decodeIfPresent(Int.self, forKey: .active) ?? 0
        critical = try decode.decodeIfPresent(Int.self, forKey: .critical) ?? 0
        deathsPerOneMillion = try decode.decodeIfPresent(Double.self, forKey: .deathsPerOneMillion) ?? 0.0
        updated = try decode.decodeIfPresent(Double.self, forKey: .updated) ?? 0.0
        countryInfo = try decode.decodeIfPresent(CountryInfoModel.self, forKey: .countryInfo)
    }
}
