//
//  CurrencyConverterViewModelTests.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

import XCTest
@testable import CurrencyApp
import RxSwift

class CurrencyConverterViewModelTests: XCTestCase {
    var sut: CurrencyConverterViewModel!
    var currenciesUseCaseMock: CurrenciesUseCaseMock!
    let bag: DisposeBag = .init()
    
    override func setUp() {
        super.setUp()
        
        currenciesUseCaseMock = .init()
        sut = CurrencyConverterViewModel(currenciesUseCaseMock)
    }

    override func tearDown() {
        super.tearDown()
        
        currenciesUseCaseMock = nil
        sut = nil
    }
    
    func testFetchCurrencySymbols() {
        // When
        sut.fetchCurrencySymbols()
        
        // Then
        XCTAssertEqual(currenciesUseCaseMock.fetchCurrencySymbolsCallCount, 1)
        sut.currencySymbols.subscribe(onNext: { values in
            XCTAssertEqual(values.count, 3)
            XCTAssertEqual(values, ["EGP", "SAR", "USD"])
        })
        .disposed(by: bag)
    }
    
    func testSwapTheConversionWithNonEmptyFromAndTo() {
        // Given
        sut.fromCurrencyRelay.accept("A")
        sut.toCurrencyRelay.accept("B")
        
        // When
        sut.swapTheConversion()
        
        // Then
        XCTAssertEqual(sut.fromCurrencyRelay.value, "B")
        XCTAssertEqual(sut.toCurrencyRelay.value, "A")
    }
    
    func testSwapTheConversionWithEmptyFromValue() {
        // Given
        sut.fromCurrencyRelay.accept("")
        sut.toCurrencyRelay.accept("B")
        
        // When
        sut.swapTheConversion()
        
        // Then
        XCTAssertEqual(sut.fromCurrencyRelay.value, "")
        XCTAssertEqual(sut.toCurrencyRelay.value, "B")
    }
}
