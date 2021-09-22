//
//  BusinessDetailDTO.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

// MARK: - BusinessDetail

public struct BusinessDetail: Codable {
    public let name: String
    public let imageURL: String
    public let phone: String
    public let reviewCount: Int
    public let rating: Int
    public let location: Location
    public let photos: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case phone
        case reviewCount = "review_count"
        case rating, location, photos
    }
}

// MARK: - Coordinates
public struct Coordinates: Codable {
    public let latitude, longitude: Double
}

//// MARK: - Location
public struct Location: Codable {
    public let address1, address2, address3, city: String
    public let country, state: String

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case country, state
    }
}



