//
//  HttpClientServiceSpy.swift
//  LookForBussinessTests
//
//  Created by carlos fernandez on 23/9/21.
//

import Foundation
import LookForBussiness

class HTTPClientServiceSpy: HTTPClient {
    
    private var messages = [(request: HTTPRequestable, completion: (HTTPClient.Result) -> Void)]()
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    var requests: [HTTPRequestable] {
        return messages.map { $0.request }
    }
    
    private struct TaskSpy: HTTPClientTask {
        let cancelCallBack: () -> Void
        func cancel() {
            cancelCallBack()
        }
    }
    
    private(set) var cancelledRequests = [HTTPRequestable]()
    
    func sendRequest(request: HTTPRequestable, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
        messages.append((request, completion))
        return TaskSpy { [weak self] in self?.cancelledRequests.append(request)}
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requests[index].url!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}


