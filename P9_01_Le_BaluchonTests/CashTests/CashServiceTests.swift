//
//  CashServiceTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 13/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class MockNetworkCallsTests: XCTestCase {
    
    var cashService: CashService!
    var configuration: URLSessionConfiguration!
    
    override func setUp() {
        super.setUp()
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        cashService  = CashService(cashSession: session)
    }
    
    func testGetCashShouldPostFailedCallbackIfError() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.IncorrectData
            return (response, data, error)
        }
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectResponse() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetCashShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .success(let cashInfo) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertEqual(cashInfo.rates["USD"], 1.17)
            XCTAssertEqual(cashInfo.rates["EUR"], 1)
            XCTAssertEqual(cashInfo.convert(value: 2, from: "EUR", to: "USD"), 2.34)
            XCTAssertEqual(cashInfo.convert(value: 2.34, from: "USD", to: "EUR"), 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
