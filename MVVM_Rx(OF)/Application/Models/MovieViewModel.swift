//
//  MovieViewModel.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 29.12.2021.
//

import Foundation

struct MoviewViewModel: Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    var image: URL {
        URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath ?? "")")!
    }
}

extension MoviewViewModel {
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
    }
}

extension MoviewViewModel {
    init() {
        self.id = 0
        self.title = "No Title"
        self.overview = "No Overview"
        self.posterPath = "No Poster Available"
    }
}
