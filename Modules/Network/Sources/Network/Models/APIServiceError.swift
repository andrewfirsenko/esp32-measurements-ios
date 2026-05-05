//
//  APIServiceError.swift
//  Network
//
//  Created by Andrew on 28.04.2026.
//

import Foundation

public enum APIServiceError: Error {
    case invalidURL
    case custom(Error)
}
