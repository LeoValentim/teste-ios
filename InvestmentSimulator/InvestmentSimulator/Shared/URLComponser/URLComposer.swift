//
//  URLComposer.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import Foundation

class URLBuilder {
    let baseURL: String
    var parameters: [String: String] = [:]
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    func compose(parameters: [String: String]) -> URLBuilder {
        parameters.forEach { self.parameters[$0.key] = $0.value }
        return self
    }
    func build() -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        let queryItems: [URLQueryItem] = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
