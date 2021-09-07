//
//  WeatherServiceTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 13/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class MockNetworkCallsTestsWeather: XCTestCase {
    
    var weatherService: WeatherService!
    
    override func setUp() {
        super.setUp()
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        weatherService  = WeatherService(weatherSession: session)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        weatherService  = WeatherService(weatherSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(city: "Paris") { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.IncorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        weatherService  = WeatherService(weatherSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(city: "Paris") { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        weatherService  = WeatherService(weatherSession: session)
        
        let expectation  = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(city: "Paris") { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        
        weatherService = WeatherService(weatherSession: session)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(city: "Paris") { (result) in
            
            guard case .success(let weatherInfo) = result else {
                XCTFail("fail")
                return
            }
            
            let weatherTemp: Double = 29.21
            let weatherIcon: String = "01d"
            let weatherDescription: String = "ciel dégagé"
            
            XCTAssertEqual(weatherIcon, weatherInfo.weather.first?.icon)
            XCTAssertEqual(weatherTemp, weatherInfo.main.temp)
            XCTAssertEqual(weatherDescription, weatherInfo.weather.first?.description)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
