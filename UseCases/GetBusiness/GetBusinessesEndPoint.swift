//
//  GetBusinessEndPoint.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public enum GetBusinessesEndPoint: HTTPRequestable {
        
    case getBusinessByTerm(term: String)
    case getBussinessByTerm(term: String, latitude: Float, longitude: Float)
    
    // Force unwrapped the url composition, is preferable to get an error compiling than a run time crash
    private var baseURL: URL? {
        return try! URL(string: "https://" + Configuration.value(for: "DOMAIN"))
    }
    
    public var url: URL? {
        let base = self.baseURL
        var relativePath: String
        
        switch self {
        case .getBusinessByTerm(_), .getBussinessByTerm(_, _, _):
            relativePath = "/businesses/search" + (self.query ?? "")
        }
        
        return URL(string: relativePath, relativeTo: base)
    }
    
    public var query: String? {
        switch self {
        case .getBusinessByTerm(let term):
            return "?term=\(term)"
        case .getBussinessByTerm(let term, let latitude, let longitude):
            return "?term=\(term)&latitude=\(latitude)&longitude=\(longitude)"
        }
    }
    
    public var headers: [String : String] {
        return ["Authorization": "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx"]
    }
}

