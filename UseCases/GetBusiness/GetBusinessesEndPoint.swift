//
//  GetBusinessEndPoint.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public enum GetBusinessesEndPoint: HTTPRequestable {
        
    case getBussinessByLocation(latitude: Double, longitude: Double)
    case getBusinessByTermAndLocation(term: String, latitude: Double, longitude: Double)
    case getBusinessByTermLocationAndRadius(term: String, latitude: Double, longitude: Double, radius: Int)
    
    // Force unwrapped the url composition, is preferable to get an error compiling than a run time crash
    private var baseURL: URL? {
        return try! URL(string: "https://" + Configuration.value(for: "DOMAIN"))
    }
    
    public var url: URL? {
        let base = self.baseURL
        var relativePath: String
        
        switch self {
        case .getBussinessByLocation(_, _), .getBusinessByTermAndLocation(_, _, _), .getBusinessByTermLocationAndRadius(_, _, _, _):
            relativePath = "businesses/search" + (self.query ?? "")
        }
        
        return URL(string: relativePath, relativeTo: base)
    }
    
    public var query: String? {
        switch self {
        case .getBussinessByLocation(let latitude, let longitude):
            return "?latitude=\(latitude)&longitude=\(longitude)"
        case .getBusinessByTermAndLocation(let term, let latitude, let longitude):
            return "?term=\(term)&latitude=\(latitude)&longitude=\(longitude)"
        case .getBusinessByTermLocationAndRadius(let term, let latitude, let longitude, let radius):
            return "?term=\(term)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)"
        }
    }
    
    // API KEY SHOULD BE OFFUSCATED
    public var headers: [String : String] {
        return ["Authorization": "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx",
                "Accept":"application/json",
                "Content-Type": "application/json"]
    }
}

