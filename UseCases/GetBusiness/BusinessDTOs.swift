//
//  BusinessDTOs.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

// MARK: - Welcome
public struct RootBusiness: Codable {
    let total: Int
    let businesses: [Business]
    let region: Region
}

// MARK: - Business
public struct Business: Codable {
    let rating: Int
    let price, phone, id, alias: String
    let isClosed: Bool
    let categories: [Category]
    let reviewCount: Int
    let name: String
    let url: String
    let coordinates: Center
    let imageURL: String
    let location: Location
    let distance: Double
    let transactions: [String]

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}

// MARK: - Center
public struct Center: Codable {
    let latitude, longitude: Double
}

// MARK: - Region
public struct Region: Codable {
    let center: Center
}

