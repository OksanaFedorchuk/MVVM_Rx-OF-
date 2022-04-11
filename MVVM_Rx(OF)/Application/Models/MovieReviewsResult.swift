//
//  MovieReviewsResult.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 07.04.2022.
//

import Foundation

// MARK: - MovieReviewsResult

struct MovieReviewsResult: Codable {
    
    let id: Int
    let productionCompanies: [ProductionCompany]
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


// MARK: - Empty MovieReviewsResult

extension MovieReviewsResult {
    init() {
        self.id = 0
        self.productionCompanies = []
    }
}


// MARK: - Coding Keys

extension MovieReviewsResult {
    
    enum CodingKeys: String, CodingKey {
        case id
        case productionCompanies = "production_companies"
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
