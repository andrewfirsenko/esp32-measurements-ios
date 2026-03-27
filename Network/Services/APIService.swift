//
//  APIService.swift
//  Network
//
//  Created by Andrew on 27.03.2026.
//

import Foundation

public final class APIService: APIServiceLogic {
    // MARK: - Constansts
    private enum Constants {
        static let scheme = "https"
        static let host = "simoresite.ru"
    }
    
    // MARK: - Init
    public init(urlSession: URLSession = URLSession.shared) {
//        self.urlSession = urlSession
    }
    
    // MARK: - Public Methods
    public func perform<T: Decodable>(endpoint: Endpoint) async throws(APIServiceError) -> T {
        throw APIServiceError.invalidURL
//        var urlComponents = URLComponents()
//        urlComponents.scheme = Constants.scheme
//        urlComponents.host = Constants.host
//        urlComponents.path = endpoint.path
//        
//        switch endpoint.payload {
//        case let .queryParameters(parameters):
//            urlComponents.queryItems = parameters.map { key, value in
//                return URLQueryItem(name: key, value: value.debugDescription)
//            }
//        }
//        
//        guard let url = urlComponents.url else { throw APIServiceError.invalidURL }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = endpoint.httpMethod.rawValue
//    
//        do {
//            let (data, _) = try await urlSession.data(for: urlRequest)
//            return try JSONDecoder().decode(T.self, from: data)
//        } catch {
//            // TODO: - Сделать нормальные ошибки
//            throw APIServiceError.custom(error)
//        }
    }
}
