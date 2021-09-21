//
//  CoreError.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public protocol GenericError: Error {
    var title: String { get }
    var message: String { get }
}

public struct CoreError: GenericError, Equatable {
    
    public enum UseCaseError: Error, Equatable {
        case getBusinesses(ApiError)
        case getBusinessDetail(ApiError)
    }
    
    public enum ApiError: Error, Equatable {
      case apiEndpointError(EndpointFail)
      case dataTaskError
      case decodeError
      case malformedRequest
    }
    
    public enum EndpointFail: Int, Equatable {
        case serverUnavailable = 500
        case badRequest = 400
        case notFound = 404
        case auth = 401
        case forbidden = 403
        case methodNotAllowed = 405
        case notAcceptable = 406
        case unknown
    }
    
    public enum ConfigurationError: Error, Equatable {
        case missingKey, invalidValue
    }
    
    // To be defined
    public var title: String
    public var message: String
    
}

extension CoreError {
    public static func errorCodeExtractor(statusCode: Int) -> CoreError.EndpointFail {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .auth
        case 403:
            return .forbidden
        case 405:
            return .methodNotAllowed
        case 406:
            return .notAcceptable
        case 500:
            return .serverUnavailable
        default:
            return .unknown
        }
    }
}
