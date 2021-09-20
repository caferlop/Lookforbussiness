//
//  HttpRequestable.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol HTTPRequestable {
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
    var query: String? { get }
    var parameters: [String: Any]? { get }
}

extension HTTPRequestable {
    public func asUrlRequest() throws -> URLRequest {
        guard let url = self.url else {
            throw CoreError.ApiError.malformedRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers
        if let requestParamenters = parameters  {
            let data = try? JSONSerialization.data(withJSONObject: requestParamenters, options: [])
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return urlRequest
    }

    public var headers: [String: String] {
        return [:]
    }

    public var method: HTTPMethod {
        return .get
    }

    public var parameters: [String: Any]? {
        return nil
    }
    
    public var query: String? {
        return nil
    }
}
