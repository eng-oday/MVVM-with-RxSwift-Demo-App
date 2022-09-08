//
//  BranchModel.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 05/09/2022.
//

import Foundation

// MARK: - BranchesModel
struct BranchesModel: Codable {
    let data: [Branch]?
    let paginator: Paginator?
    let statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data, paginator
        case statusCode = "status_code"
    }
}

// MARK: - Datum
struct Branch: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Paginator
struct Paginator: Codable {
    let currentPage, perPage, prevPage, prevPageURL: Int?
    let nextPage, nextPageURL, pages, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case prevPage = "prev_page"
        case prevPageURL = "prev_page_url"
        case nextPage = "next_page"
        case nextPageURL = "next_page_url"
        case pages, total
    }
}
