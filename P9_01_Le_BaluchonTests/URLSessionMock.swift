//
//  URLSessionMock.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 19/08/2021.
//

import Foundation
@testable import P9_01_Le_Baluchon

//class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
//    private let closure: () -> Void
//    init(closure: @escaping () -> Void) {
//        self.closure = closure
//    }
//    // override resume and call the closure
//
//    func resume() {
//        closure()
//    }
//}

class DataTaskMock: URLSessionDataTask {
    
    override func resume() { }
    
}

class URLSessionMock: URLSessionProtocol {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        
        let data = self.data
        let error = self.error
//        let response = HTTPURLResponse(url: URL(string:"URL")!, statusCode: 200, httpVersion: nil, headerFields: nil)
//
//        URLProtocolMock.mockURLs = [url: (nil, data, response)]

        defer { completionHandler(data, nil, error) }
        
        return DataTaskMock()
    }
}

