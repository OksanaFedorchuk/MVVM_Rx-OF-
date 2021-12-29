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
    
    func searchRepos<T: Decodable>(withQuery query: String, for urlRequest: URLRequest) -> Observable<[T]> {
        return URLSession.shared.rx.data(request: urlRequest)
            .map { data -> [T] in
                guard let response = try? JSONDecoder().decode(T.self, from: data) else { return [] }
                return [response]
            }
    }
}
