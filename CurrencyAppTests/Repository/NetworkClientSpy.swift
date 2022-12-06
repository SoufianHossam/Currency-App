//
//  Network Client Spy.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

@testable import CurrencyApp
import Foundation

class NetworkClientSpy: NetworkClientProtocol {
    var requestCallCount: Int = 0
    
    func request<T>(_ request: Request<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        requestCallCount += 1
    }
}
