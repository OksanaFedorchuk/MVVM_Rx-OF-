//
//  NetworkService.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class NetworkService {
    
    func searchRepos<T: Decodable>(withQuery query: String) -> Observable<[T]> {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
        return URLSession.shared.rx.data(request: request)
            .map { data -> [T] in
                guard let response = try? JSONDecoder().decode(T.self, from: data) else { return [] }
                return [response]
            }
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
    
    func getRepos() -> Observable<[Response]> {
//        return networkService.execute(url: url)
//        let url = setReposUlr(matching: "swift", sortedBy: .numberOfStars, inOrder: .ascending, perPage: "30")
       return searchRepos(withQuery: "swift")
   }
}
