//
//  NetworkLayer.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 10/02/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noInternetConnection
    case serverError(String?)
}

/// Protocol that defines how to work with http requests in the project. It helps to use different Networking Libraries.
protocol NetworkLayer {
    typealias NetworkResult<T> = Result<T, Error>
    typealias TryAgainAction = (() -> Void)?

    var isConnectedToInternet: Bool { get }

    // MARK: - GET
    func get(_ url: URL,
             headers: [String: String]?,
             completion: @escaping (NetworkResult<Data>) -> Void)
    func get<T: Codable>(_ url: URL,
                         model: T.Type,
                         headers: [String: String]?,
                         completion: @escaping (NetworkResult<T>) -> Void)

    // MARK: - POST
    func post(_ url: URL,
              params: [String: Any],
              headers: [String: String]?,
              completion: @escaping (NetworkResult<Data>) -> Void)
    func post<T: Codable>(_ url: URL,
                          model: T.Type,
                          params: [String: Any],
                          headers: [String: String]?,
                          completion: @escaping (NetworkResult<T>) -> Void)
}
