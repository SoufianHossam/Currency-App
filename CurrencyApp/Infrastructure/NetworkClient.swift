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
                    let customError = resolve(error: error)
                    completion(.failure(customError))
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    let error = handleErrorStatusCode(response)
                    completion(.failure(error))
                    return
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
    
    private func handleErrorStatusCode(_ response: URLResponse?) -> NetworkError {
        guard let response = response as? HTTPURLResponse else {
            return NetworkError.networkFailure("No Response")
        }

        switch response.statusCode {
        case 400:
            return NetworkError.badRequest
            
        case 401:
            return NetworkError.unauthorized
            
        case 404:
            return NetworkError.notFound
            
        case 429:
            return NetworkError.tooManyRequests
            
        case _ where response.statusCode >= 500:
            return NetworkError.serverError

        default:
            return NetworkError.networkFailure("Unknown status code")
        }
    }
}
