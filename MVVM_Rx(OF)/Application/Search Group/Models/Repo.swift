//
//  Repo.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation

struct Response: Decodable {
    let items: [Repo]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case count = "total_count"
    }
}

struct Repo: Decodable {
    
    let id: Int
    let name: String
    let svnURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case svnURL = "svn_url"
    }
}
