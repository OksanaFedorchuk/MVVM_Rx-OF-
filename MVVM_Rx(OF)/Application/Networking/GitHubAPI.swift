//
//  GitHubAPI.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum Sorting: String {
    case numberOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
}

enum Order: String {
    case ascending = "asc"
    case descending = "desc"
}

final class GitHubAPI {
    
    private let networkService = NetworkService()
    
    public func setReposUlr(matching query: String,
                            sortedBy sorting: Sorting,
                            inOrder order: Order,
                            perPage number: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: sorting.rawValue),
            URLQueryItem(name: "order", value: order.rawValue),
            URLQueryItem(name: "per_page", value: number)
        ]
        
        guard let url = components.url else {return URL(string: "https://api.github.com/zen")!}
        print("MYDEBUG: url: \(String(describing: url.absoluteString))")
        return url
    }
    
    public func getRepos(withQuery query: String, for url: URL) -> Observable<[Response]> {
        return networkService.searchRepos(withQuery: query, for: url)
    }
}
