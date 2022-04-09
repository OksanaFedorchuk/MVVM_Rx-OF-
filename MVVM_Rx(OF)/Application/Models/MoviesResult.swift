//
//  MoviesResult.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation

// MARK: - MoviesResult

struct MoviesResult: Codable {
    
    let totalPages: Int
    let movies: [Movie]?
}


// MARK: - Movie

struct Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    
    var imageURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath ?? "")")!
    }
}


// MARK: - Movie Equatable

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - Empty Movie

extension Movie {
    
    init() {
        self.id = 0
        self.title = "No Title"
        self.overview = "No Overview"
        self.posterPath = ""
        self.backdropPath = ""
        self.voteAverage = 0.0
    }
}

// MARK: - Coding Keys


extension MoviesResult {
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case movies = "results"
    }
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
