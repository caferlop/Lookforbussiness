//
//  BusinessDTOs.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

import Foundation

// MARK: - RootBusiness
public struct RootBusiness: Codable {
    public let businesses: [Business]
    public let total: Int?
    public let region: Region?
}

// MARK: - Business
public struct Business: Codable, Equatable {
    public let id, alias, name: String
    public let coordinates: Center

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case coordinates//, location
    }
}


// MARK: - Center
public struct Center: Codable, Equatable {
    public let latitude, longitude: Double
}

// MARK: - Region
public struct Region: Codable {
    public let center: Center
}

