//
//  MovieDetailsResult.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 07.04.2022.
//

import Foundation

// MARK: - MovieDetailsResult

struct MovieDetailsResult: Codable {
    
    let id: Int
    let productionCompanies: [ProductionCompany]
    let homepage: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    
    let id: Int
    let logoPath: String?
    let name, originCountry: String
    
    var logoURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w300/\(logoPath ?? "")")!
    }
}


// MARK: - Empty MovieDetailsResult

extension MovieDetailsResult {
    init() {
        self.id = 0
        self.productionCompanies = []
        self.homepage = ""
    }
}


// MARK: - Coding Keys

extension MovieDetailsResult {
    
    enum CodingKeys: String, CodingKey {
        case id
        case productionCompanies = "production_companies"
        case homepage
    }
}

extension ProductionCompany {
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
