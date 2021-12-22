//
//  Repo.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 18.12.2021.
//

import Foundation

struct Response: Codable {
    let items: [Repo]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case count = "total_count"
    }
}

struct Repo: Codable {
    
    let id: Int
    let name: String
    let svnURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case svnURL = "svn_url"
    }
}

extension Repo {
    init(repo: RepoViewModel) {
        self.name = repo.name
        self.id = repo.id
        self.svnURL = repo.svnURL
    }
}
