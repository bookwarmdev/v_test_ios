//
//  NetworkManager.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation
import Combine


class NetworkManager {
    static let shared = NetworkManager()

    func getData(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURLString
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.notFoundString
            }
            
            // Print the response for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("=============  ===============")
                print("JSON Response: \(jsonString)")
                print("Status Code: \(httpResponse.statusCode)")
                print("============= END ===============")
            }
            
            // Handle the HTTP response status codes
            switch httpResponse.statusCode {
            case 200:
                return data // Return the raw data on success
            case 400:
                throw NetworkError.badRequestString
            case 401:
                throw NetworkError.serverErrorString
            case 500:
                throw NetworkError.serverErrorString
            default:
                throw NetworkError.notFoundString
            }
            
        } catch let error as URLError {
            print("===== Error \(error) ======")
            switch error.code {
            case .notConnectedToInternet:
                throw NetworkError.noInternetConnectionString
            case .timedOut:
                throw NetworkError.timeoutString
            default:
                throw NetworkError.socketExceptionString
            }
        } catch {
            throw NetworkError.cacheErrorString
        }
    }
    
    func parseResponse<T: Decodable>(_ data: Data, type: T.Type) async throws -> T {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type mismatch error: \(type) - \(context)")
            // Handle type mismatch error specifically if needed
            print("Type mismatch: \(context.debugDescription)")
            throw NetworkError.badRequestString
        } catch let error {
            // Handle other errors
            print("Decoding error occurred: \(error)")
            throw error
        }
    } 
}
