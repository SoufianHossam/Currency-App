//
//  NetworkService.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T>(_ request: Request<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkClient: NetworkClientProtocol {
    func request<T>(_ request: Request<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let urlRequest = try request.asURLRequest()
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    let customError: NetworkError
                    
                    if let _ = response as? HTTPURLResponse {
                        customError = .networkFailure(error.localizedDescription)
                    } else {
                        customError = resolve(error: error)
                    }
                    
                    completion(.failure(customError))
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                #if DEBUG
                print(String(data: data, encoding: .utf8)!)
                #endif
                
                do {
                    let response = try request.parse(data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(.parsing(error)))
                }
            }
            
            task.resume()
            
        } catch {
            completion(.failure(.networkFailure(error.localizedDescription)))
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        
        switch code {
        case .notConnectedToInternet:
            return .noInternetConnection
            
        default:
            return .networkFailure(error.localizedDescription)
        }
    }
}

