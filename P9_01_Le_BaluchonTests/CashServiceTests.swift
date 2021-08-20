//
//  CashServiceTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 13/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class CashServiceTests: XCTestCase {
    
    class MockNetworkCallsTests: XCTestCase {
        
        func testDownloadUnreliableForCashService() {
            
            let exp = expectation(description: "Loading URL")
            let cashService = CashService()
            cashService.getCash(URLSession.shared, completion: {data in exp.fulfill()
            })
            waitForExpectations(timeout: 10)
        }
        
        func testCashUsingSimpleMockForCashService() {
            
            let mockSession = URLSessionMock()
            mockSession.data = "testData".data(using: .ascii)
            let exp = expectation(description: "Loading URL")
            let cashService =  CashService()
            cashService.getCash(mockSession, completion: {data in exp.fulfill()
            })
            waitForExpectations(timeout: 0.1)
        }
    }
}
