//
//  SavedMovies.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import UIKit

struct SavedMovies {
    static var savedMovies: [Movie] {
        get {
            guard let movies = UserDefaults.standard.array(forKey: K.defaultsName.movies) as? [Data] else {return []}
            return movies.map { try! JSONDecoder().decode(Movie.self, from: $0) }
        }
        set {
            let data = newValue.map { try? JSONEncoder().encode($0)}
            UserDefaults.standard.setValue(data, forKey: K.defaultsName.movies)
        }
    }
}