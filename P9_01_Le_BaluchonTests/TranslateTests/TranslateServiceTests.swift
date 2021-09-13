//
//  TranslateServiceTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 13/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class MockNetworkCallsTestsTranslate: XCTestCase {
    
    var translateService: TranslateService!
    
    override func setUp() {
        super.setUp()
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data = FakeResponseData.translateCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        translateService  = TranslateService(translateSession: session)
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
        
        translateService  = TranslateService(translateSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.postTranslate(language: "Bonjour") { (result) in
            
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
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        translateService  = TranslateService(translateSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.postTranslate(language: "Bonjour") { (result) in
            
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
            let data: Data? = FakeResponseData.translateCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        translateService  = TranslateService(translateSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.postTranslate(language: "Bonjour") { (result) in
            
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
            let data: Data? = FakeResponseData.translateCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        translateService  = TranslateService(translateSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.postTranslate(language: "Bonjour") { (result) in
            
            guard case .success(let translateInfo) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertEqual(translateInfo.data.translations[0].translatedText, "Hello")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
