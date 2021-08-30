//
//  CashServiceTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 13/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class MockNetworkCallsTests: XCTestCase {
    
    func testGetCashShouldPostFailedCallbackIfError() {
        // Given
        let cashService = CashService(cashSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Loading URL")
        
        cashService.getCash { (success, cash) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cash)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCashShouldPostFailedCallbackNoData() {
        // Given
        let cashService = CashService(cashSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Loading URL")
        
        cashService.getCash { (success, cash) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cash)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let cashService = CashService(cashSession: URLSessionFake(data: FakeResponseData.cashCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Loading URL")
        
        cashService.getCash { (success, cash) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cash)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCashShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let cashService = CashService(cashSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Loading URL")
        
        cashService.getCash { (success, cash) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cash)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCashShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let cashService = CashService(cashSession: URLSessionFake(data: FakeResponseData.cashCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Loading URL")
        
        cashService.getCash { (success, cash) in
            // Then
            let rates = ["USD", 1.17]
            XCTAssertTrue(success)
            XCTAssertNotNil(cash)
            XCTAssertEqual(rates, cash!.rates)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
