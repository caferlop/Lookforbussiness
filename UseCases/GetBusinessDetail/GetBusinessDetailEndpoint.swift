//
//  GetBusinessDetailEndpoint.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public enum GetBusinessDetailEndPoint: HTTPRequestable {
        
    case getBusinessDetailById(id: String)
    // Force unwrapped the url composition, is preferable to get an error compiling than a run time crash 
    private var baseURL: URL? {
        return try! URL(string: "https://" + Configuration.value(for: "DOMAIN"))
    }
    
    public var url: URL? {
        let base = self.baseURL
        var relativePath: String
        
        switch self {
        case .getBusinessDetailById(let id):
            relativePath = "/businesses/search/\(id)"
        }
        
        return URL(string: relativePath, relativeTo: base)
    }
    
    
    public var headers: [String : String] {
        return ["Authorization": "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx"]
    }
}
