//
//  GenericHTTPClient.swift
//  LookForBussiness
//
//  Created by carlos fernandez on 20/9/21.
//

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    @discardableResult
    func sendRequest(request: HTTPRequestable, completion: @escaping(Result) -> Void) -> HTTPClientTask?
}

public final class GenericHTTPClient: NSObject {
    private var session: URLSession?
    public init(session: URLSession?) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
}

extension GenericHTTPClient: HTTPClient {
    public func sendRequest(request: HTTPRequestable, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
        do {
            let newRequest = try request.asUrlRequest()
            let task = session?.dataTask(with: newRequest) { data, response, error in
                completion(Result {
                    if let error = error {
                        throw error
                    } else if let data = data, let response = response as? HTTPURLResponse {
                        return (data, response)
                    } else {
                        throw UnexpectedValuesRepresentation()
                    }
                })
            }
            task?.resume()
            return URLSessionTaskWrapper(wrapped: task!)
        } catch (let error) {
            completion(.failure(error))
            return nil
        }
    }
}
