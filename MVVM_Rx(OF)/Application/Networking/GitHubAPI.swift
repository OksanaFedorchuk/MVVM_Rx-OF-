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

class GitHubAPI {
    
    private let networkService = NetworkService()
    
    //    "https://api.github.com/search/repositories?sort=star&order=desc&per_page=30&q=swift"
    
    public func getRepos() -> Observable<[Response]> {
        //        return networkService.execute(url: url)
        return networkService.execute(url: URL(string: "https://api.github.com/search/repositories?sort=star&order=desc&per_page=30&q=swift")!)
    }
    
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
}
