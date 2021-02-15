//
//  NetworkURLSession.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 10/02/21.
//

import Foundation
import SystemConfiguration

/// URLSession class that conforms to Network layer protocol
class NetworkURLSession: NetworkLayer {
    var isConnectedToInternet: Bool {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        return flags.contains(.reachable) || flags.contains(.isWWAN)
    }

    func generateRequest(url: URL) -> URLRequest {
        let resquest = URLRequest(url: url)
        return resquest
    }

    /// GET Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - headers: Http Header
    ///   - completion: Result Data
    func get(_ url: URL, headers: [String: String]?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard isConnectedToInternet else {
            let error = NetworkError.noInternetConnection
            completion(.failure(error))
            return
        }

        var request = generateRequest(url: url)
        request.httpMethod = "GET"
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.serverError(nil)))
                    return
                }
                completion(.success(data))
            }
        }).resume()
    }
    /// GET Request that returns codable generics type
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - model: Type that will be decoded
    ///   - headers: Http Header
    ///   - completion: Result Data
    func get<T: Codable>(_ url: URL,
                         model: T.Type,
                         headers: [String: String]?,
                         completion: @escaping (Result<T, Error>) -> Void) {
        get(url, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    completion(.success(resultObjc))
                } catch {
                    completion(.failure(error))
            }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    /// POST Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - params: Http body
    ///   - headers: Http Header
    ///   - completion: Result Data
    func post(_ url: URL,
              params: [String: Any],
              headers: [String: String]?,
              completion: @escaping (Result<Data, Error>) -> Void) {
        guard isConnectedToInternet else {
            let error = NetworkError.noInternetConnection
            completion(.failure(error))
            return
        }

        var request = generateRequest(url: url)
        request.httpMethod = "POST"
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = try? NSKeyedArchiver.archivedData(withRootObject: params, requiringSecureCoding: true)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.serverError(nil)))
                    return
                }

                completion(.success(data))
            }
        }).resume()
    }

    /// POST Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - model: Type that will be decoded
    ///   - params: Http body
    ///   - headers: Http Header
    ///   - completion: Result Data
    func post<T: Codable>(_ url: URL,
                          model: T.Type,
                          params: [String: Any],
                          headers: [String: String]?,
                          completion: @escaping (Result<T, Error>) -> Void) {
        post(url, params: params, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    completion(.success(resultObjc))
                } catch {
                    completion(.failure(error))
            }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
