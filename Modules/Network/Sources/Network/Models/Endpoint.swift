//
//  Endpoint.swift
//  Network
//
//  Created by Andrew on 27.03.2026.
//

import Foundation

// MARK: - Endpoint
public protocol Endpoint {
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var payload: EndpointPayload { get }
}

// MARK: - HttpMethod
public enum HttpMethod: String {
    case get = "GET"
}

// MARK: - EndpointPayload
public enum EndpointPayload {
    case queryParameters([String: Any?])
}
