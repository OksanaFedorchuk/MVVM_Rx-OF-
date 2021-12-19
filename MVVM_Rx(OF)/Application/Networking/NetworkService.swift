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
    
    func searchRepos<T: Decodable>(withQuery query: String, for url: URL) -> Observable<[T]> {
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .map { data -> [T] in
                guard let response = try? JSONDecoder().decode(T.self, from: data) else { return [] }
                return [response]
            }
    }
}
