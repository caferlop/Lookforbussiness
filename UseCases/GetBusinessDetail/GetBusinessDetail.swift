//
//  GetBusinessDetail.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

public protocol BusinessDetailable: AnyObject {
    typealias ResultBusinessDetail = Swift.Result<BusinessDetail, Error>
    func getBusinessDetail(request: HTTPRequestable, completion: @escaping (ResultBusinessDetail) -> Void)
}

public final class GetBusinessDetail: BusinessDetailable {
    
    private let restClient: HTTPClient
    
    public init(restClient: HTTPClient) {
        self.restClient = restClient
    }
    
    public func getBusinessDetail(request: HTTPRequestable, completion: @escaping (ResultBusinessDetail) -> Void) {
        self.restClient.sendRequest(request: request) { result in
            switch result {
            case .success((let data, let httpResponse)):
                do {
                    let business = try BusinessDetailParser.parseBusinessDetail(data: data, from: httpResponse)
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
