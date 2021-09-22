//
//  BusinessesParser.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

final class BusinessesParser {
    
    private static var OK_200: Int { return 200 }
    
    static func parseBusinesses(data: Data, from response: HTTPURLResponse) throws -> [Business] {
        if response.statusCode == OK_200 {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("json:", json)
                let root = try JSONDecoder().decode(RootBusiness.self, from: data)
                return root.businesses
            } catch  {
                throw CoreError.UseCaseError.getBusinesses(.decodeError)
            }
        } else {
            let endPointFail = CoreError.errorCodeExtractor(statusCode: response.statusCode)
            throw CoreError.UseCaseError.getBusinesses(.apiEndpointError(endPointFail))
        }
    }
}
