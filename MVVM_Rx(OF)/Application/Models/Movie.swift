//
//  Movie.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation

struct Response: Codable {
    let totalPages: Int
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

extension Movie {
    var image: URL {
        URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath ?? "")")!
    }
}

extension Movie {
    init() {
        self.id = 0
        self.title = "No Title"
        self.overview = "No Overview"
        self.posterPath = "No Poster Available"
        self.backdropPath = "No Image Available"
        self.voteAverage = 0.0
    }
}
