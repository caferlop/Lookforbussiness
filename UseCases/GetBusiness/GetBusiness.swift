//
//  GetBusiness.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public protocol BusinessSearchable: AnyObject {
    typealias ResultBusinesses = Swift.Result<[Business], Error>
    func getBusinessess(request: HTTPRequestable, completion: @escaping (ResultBusinesses) -> Void)
    
}

public final class GetBusinesses: BusinessSearchable {
    
    private let restClient: HTTPClient
    
    public init(restClient: HTTPClient) {
        self.restClient = restClient
    }
    
    public func getBusinessess(request: HTTPRequestable, completion: @escaping (ResultBusinesses) -> Void) {
        self.restClient.sendRequest(request: request) { result in
            switch result {
            case .success((let data, let httpResponse)):
                do {
                    let business = try BusinessesParser.parseBusinesses(data: data, from: httpResponse)
                    completion(.success(business))
                } catch let error{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
