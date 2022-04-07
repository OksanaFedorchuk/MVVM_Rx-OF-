//
//  MovieDBAPI.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDBAPI {
    
    private let networkService = NetworkService()
    
    //making api call for searched movies
    public func getMovie(withQuery query: String, for page: Int) -> Observable<[MoviesResult]> {
        //construct valid url for the given search text and page number
        let url = setMoviesUlr(matching: query, page: "\(page)")
        let request = URLRequest(url: url)
        
        return networkService.apiCall(for: request)
            .debug()
    }
    
    //building url for search call with static and varying parametes
    private func setMoviesUlr(matching query: String,
                              page: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "b5977e527a6e071133ebf0f33054db08"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "query", value: query)
        ]
        
        guard let url = components.url else {return URL(string: "https://api.github.com/zen")!}
        print("MYDEBUG: url: \(String(describing: url.absoluteString))")
        return url
    }
}
