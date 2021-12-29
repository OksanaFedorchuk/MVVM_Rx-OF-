//
//  Movie.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation

struct Response: Codable {
    let totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

extension Movie {
    init(movie: MoviewViewModel) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
    }
}
