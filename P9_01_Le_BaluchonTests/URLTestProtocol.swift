//
//  URLTestProtocol.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 30/08/2021.
//

import Foundation

import XCTest
@testable import P9_01_Le_Baluchon

final class URLTestProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        
        return request
    }

    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?

    override func startLoading() {
        
        guard let handler = URLTestProtocol.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        
        let (response, data, _) = handler(request)
        if let data = data {
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            class ProtocolError: Error {}
            let protocolError = ProtocolError()
            client?.urlProtocol(self, didFailWithError: protocolError)
        }
    }

    override func stopLoading() {
    }
    
}
