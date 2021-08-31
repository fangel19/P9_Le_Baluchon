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
    
    override func setUp() {
        super.setUp()
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
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
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        cashService  = CashService(cashSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCashShouldPostFailedCallbackNoData() {
        
        
        //        // Given
        //        let cashService = CashService(cashSession: URLSessionFake(data: nil, response: nil, error: nil))
        //        // When
        //        let expectation = XCTestExpectation(description: "Wait for queue change.")
        //
        //        cashService.getCash { (success, cash) in
        //            // Then
        //            XCTAssertFalse(success)
        //            XCTAssertNil(cash)
        //            expectation.fulfill()
        //        }
        //
        //        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.IncorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        cashService  = CashService(cashSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectResponse() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        cashService  = CashService(cashSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCashShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.cashCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        cashService  = CashService(cashSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        cashService.getCash { (result) in
            
            guard case .success(let cashInfo) = result else {
                XCTFail("fail")
                return
            }
            XCTAssertEqual(cashInfo.rates["USD"], 1.17)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

