//
//  APIServiceLogic.swift
//  Network
//
//  Created by Andrew on 27.03.2026.
//

import Foundation

public protocol APIServiceLogic: AnyObject {
    func perform<T: Decodable>(endpoint: Endpoint) async throws(APIServiceError) -> T
}
