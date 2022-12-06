//
//  CurrenciesUseCaseTests.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

import XCTest
@testable import CurrencyApp

class CurrenciesUseCaseTests: XCTestCase {
    var sut: CurrenciesUseCase!
    var repoSpy: RepoSpy!
    
    override func setUp() {
        super.setUp()
        repoSpy = .init()
        sut = CurrenciesUseCase(repoSpy)
    }

    override func tearDown() {
        super.tearDown()
        repoSpy = nil
        sut = nil
    }

    func testFetchCurrencySymbols() {
        // When
        sut.fetchCurrencySymbols { _ in }

        // Then
        XCTAssertEqual(repoSpy.fetchCurrencySymbolsCallCount, 1)
    }
    
    func testFetchHistoricalData() {
        // When
        sut.fetchHistoricalData(.stub()) { _ in }
        
        // Then
        XCTAssertEqual(repoSpy.fetchHistoricalDataCallCount, 1)
    }
    
    func testConvertCurrencyUsingFromFieldShouldNotFlipTheFields() {
        // When
        sut.convertCurrency(.stub(fromCurrency: "EGP",
                                  toCurrency: "USD")) { _ in }
        
        // Then
        XCTAssertEqual(repoSpy.convertCurrencyCallCount, 1)
        XCTAssertEqual(repoSpy.conversionInput?.fromCurrency, "EGP")
        XCTAssertEqual(repoSpy.conversionInput?.toCurrency, "USD")
    }
    
    func testConvertCurrencyUsingToFieldShouldFlipTheValues() {
        // When
        sut.convertCurrency(.stub(fromCurrency: "EGP",
                                  toCurrency: "USD",
                                  amount: .to(1))) { _ in }
        
        // Then
        XCTAssertEqual(repoSpy.convertCurrencyCallCount, 1)
        XCTAssertEqual(repoSpy.conversionInput?.fromCurrency, "USD")
        XCTAssertEqual(repoSpy.conversionInput?.toCurrency, "EGP")
    }
}
