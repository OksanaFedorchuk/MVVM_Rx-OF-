//
//  MovieReviewsResult.swift
//  MVVM_Rx(OF)
//
//  Created by Oksana Fedorchuk on 07.04.2022.
//

import Foundation

// MARK: - MovieReviewsResult

struct MovieReviewsResult: Codable {
    
    let id, page: Int
    let reviews: [Review]
    let totalPages, totalResults: Int
}


// MARK: - Review

struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String
}

extension Review: Equatable {
    static func == (lhs: Review, rhs: Review) -> Bool {
        lhs.id == rhs.id
    }
}

extension Review: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - AuthorDetails

struct AuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}


// MARK: - Empty MovieReviewsResult

extension MovieReviewsResult {
    init() {
        self.id = 0
        self.page = 0
        self.reviews = []
        self.totalPages = 0
        self.totalResults = 0
    }
}


// MARK: - Coding Keys

extension MovieReviewsResult {
    
    enum CodingKeys: String, CodingKey {
        case id, page
        case reviews = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension Review {
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
