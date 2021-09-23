//
//  GetBusinessUseCase.swift
//  LookForBussinessTests
//
//  Created by carlos fernandez on 23/9/21.
//

import XCTest
@testable import LookForBussiness

class GetBusinessUseCase: XCTestCase {
    
    func test_getBusinesses_deliversItemsOn200ResponseWithJSONList() {
        let dummyRequest = makeGetBussinessRequest()
        let (sut, client) = makeSUT()

        let business1 = makeABusiness()
        let business2 = makeABusiness()
        
        let businesses = [business1.model, business2.model]
        
        expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .success(businesses)) {
            let json = makeItemsJSON(["businesses":[business1.json, business2.json]])
            client.complete(withStatusCode: 200, data: json)
        }
    }
    
    
    private func makeGetBussinessRequest() -> HTTPRequestable {
        return GetBusinessesEndPoint.getBussinessByLocation(latitude: 0, longitude: 0)
    }
    
    private func makeABusiness() -> (model: Business, json: [String: Any]) {
        let item = Business(id: "test_1", alias: "Business_test", name: "Elx Costra", coordinates: Center(latitude: 0, longitude: 0))
        let json = ["id": item.id, "alias": item.alias, "name": item.name, "coordinates": ["longitude":0, "latitude": 0]].compactMapValues { $0 }
        return (item, json)
    }
    
    private func makeItemsJSON(_ items: [String: Any]) -> Data {
        let json = items
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeItemJSON(_ item: [String: Any]) -> Data {
        let json = item
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    func test_getBusinesses_deliversErrorOnNon200HTTPResponse() {
        let dummyRequest = makeGetBussinessRequest()
        let (sut, client) = makeSUT()

        let samples = [400, 406, 401, 403, 405, 500]

        samples.enumerated().forEach { index, code in
            switch code {
            case 400:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.badRequest)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            case 401:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.auth)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            case 406:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.notAcceptable)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            case 403:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.forbidden)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            case 405:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.methodNotAllowed)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            case 500:
                expectGetBusiness(sut: sut, request: dummyRequest, toCompleteWith: .failure(CoreError.UseCaseError.getBusinesses(.apiEndpointError(.serverUnavailable)))) {
                    let json = makeItemsJSON([:])
                    client.complete(withStatusCode: code, data: json, at: index)
                }
            default:
                break
            }

        }
    }
    

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: GetBusinesses, client: HTTPClientServiceSpy) {
        let client = HTTPClientServiceSpy()
        let sut = GetBusinesses(restClient: client)

        return(sut, client)
    }
    
    
    private func expectGetBusiness(sut: GetBusinesses, request: HTTPRequestable, toCompleteWith expectedResult: BusinessSearchable.ResultBusinesses, when action: ()-> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait to get business to complete")
        
        sut.getBusinessess(request: request) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

            case let (.failure(receivedError as CoreError.UseCaseError), .failure(expectedError as CoreError.UseCaseError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()

        wait(for: [exp], timeout: 1.0)
    }

}

