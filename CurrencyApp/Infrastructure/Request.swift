//
//  Request.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case noInternetConnection
    case parsing(Error)
    case networkFailure(String)
    case badRequest
    case unauthorized
    case notFound
    case tooManyRequests
    case serverError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

typealias Parameters = [String: Any]

struct Request<Output: Decodable> {
    let path: String
    let method: HTTPMethod
    let parameters: Parameters?
    let parse: (Data) throws -> Output

    init(path: String,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil,
         parse: @escaping (Data) throws -> Output) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.parse = parse
    }
}

extension Request {
    init(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil) {
        self.init(path: path, method: method, parameters: parameters) { data in
            try JSONDecoder().decode(Output.self, from: data)
        }
    }
}

extension Request {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: NetworkConfigurations.baseURI + path) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)

        NetworkConfigurations.httpHeaders?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        guard let parameters = parameters else { return urlRequest }
        
        switch method {
        case .get:
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw NetworkError.invalidURL
            }
            
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            
            guard let componentsQueryURL = urlComponents.url else {
                throw NetworkError.invalidURL
            }
            
            urlRequest.url = componentsQueryURL
            
        case .post:
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return urlRequest
    }
}
