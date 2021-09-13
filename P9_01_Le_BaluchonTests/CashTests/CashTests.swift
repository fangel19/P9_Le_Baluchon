//
//  CashTests.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 19/08/2021.
//

import XCTest
@testable import P9_01_Le_Baluchon

class CashTests: XCTestCase {
    
    let cash =  CashInfo(rates: ["USD" : 1.17])
    
    func testCashConvertResultItsCorrectFromEUR() {
        
        let result =  cash.convert(value: 2, from: "EUR", to: "USD")
        XCTAssertEqual(result, 2.34)
    }
}
