//
//  CurrenciesRepositoryTests.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

import XCTest
@testable import CurrencyApp

class CurrenciesRepositoryTests: XCTestCase {
    var sut: CurrenciesRepository!
    var networkClientSpy: NetworkClientSpy!
    
    override func setUp() {
        super.setUp()
        networkClientSpy = .init()
        sut = CurrenciesRepository(networkClientSpy)
    }

    override func tearDown() {
        super.tearDown()
        networkClientSpy = nil
        sut = nil
    }

    func testFetchCurrencySymbols() {
        // When
        sut.fetchCurrencySymbols { _ in }
        
        // Then
        XCTAssertEqual(networkClientSpy.requestCallCount, 1)
    }
    
    func testConvertCurrency() {
        // When
        sut.convertCurrency(.stub()) { _ in }
        
        // Then
        XCTAssertEqual(networkClientSpy.requestCallCount, 1)
    }
    
    func testFetchHistoricalData() {
        // When
        sut.fetchHistoricalData(.stub()) { _ in }
        
        // Then
        XCTAssertEqual(networkClientSpy.requestCallCount, 1)
    }
}
