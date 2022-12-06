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
    
    func testIsCurrenciesSelectedWhenOneCurrencyOnlyIsSelected() {
        // Given
        sut.toCurrencyRelay.accept("B")
        
        // When
        sut.isCurrenciesSelected
            .subscribe(onNext: { isSelected in
                // Then
                XCTAssertFalse(isSelected)
            })
            .disposed(by: bag)
    }
    
    func testIsCurrenciesSelectedWhenBothCurrenciesAreSelected() {
        // Given
        sut.fromCurrencyRelay.accept("A")
        sut.toCurrencyRelay.accept("B")
        
        // When
        sut.isCurrenciesSelected
            .subscribe(onNext: { isSelected in
                // Then
                XCTAssertTrue(isSelected)
            })
            .disposed(by: bag)
    }
    
    func testSelectedCurrenciesDetailsWhenNoCurrenciesSelectedShouldDoNothing() {
        // Given
        sut.fromCurrencyRelay.accept("")
        sut.toCurrencyRelay.accept("")
        sut.detailsRelay.accept(())
        
        // When
        sut.selectedCurrenciesDetails
            .subscribe(onNext: { _ in
                // Then
                XCTFail()
            })
            .disposed(by: bag)
    }
    
    func testSelectedCurrenciesDetailsWhenOneCurrencySelectedShouldDoNothing() {
        // Given
        sut.selectedCurrenciesDetails
            .subscribe(onNext: { _ in
                // Then
                XCTFail()
            })
            .disposed(by: bag)
        
        
        // When
        sut.fromCurrencyRelay.accept("A")
    }
    
    func testSelectedCurrenciesDetailsWhenBothCurrenciesSelectedShouldSendAnEvent() {
        // Given
        sut.selectedCurrenciesDetails
            .subscribe(onNext: { currencies in
                // Then
                XCTAssertEqual(currencies.0, "A")
                XCTAssertEqual(currencies.1, "B")
            })
            .disposed(by: bag)

        // When
        sut.fromCurrencyRelay.accept("A")
        sut.toCurrencyRelay.accept("B")
        sut.detailsRelay.accept(())
    }
    
    func testConvertFunctionalityWhenAllFieldsAreFilled() {
        // Given
        sut.amountRelay.accept(.from(10))
        sut.fromCurrencyRelay.accept("A")
        sut.toCurrencyRelay.accept("B")

        let expectation = XCTestExpectation(description: "Debouncing")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        // When
        wait(for: [expectation], timeout: 3)
        
        // Then
        XCTAssertEqual(self.currenciesUseCaseMock.convertCurrencyCallCount, 1)
    }
}
