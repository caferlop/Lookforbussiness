//
//  BusinessDetailParser.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

import Foundation

final class BusinessDetailParser {
    
    private static var OK_200: Int { return 200 }
    
    static func parseBusinessDetail(data: Data, from response: HTTPURLResponse) throws -> BusinessDetail {
        if response.statusCode == OK_200 {
            do {
                let root = try JSONDecoder().decode(BusinessDetail.self, from: data)
                return root
            } catch  {
                throw CoreError.UseCaseError.getBusinessDetail(.decodeError)
            }
        } else {
            let endPointFail = CoreError.errorCodeExtractor(statusCode: response.statusCode)
            throw CoreError.UseCaseError.getBusinessDetail(.apiEndpointError(endPointFail))
        }
    }
}
