//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 21.12.2022.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    var accessToken: String
    var tokenType: String
    var scope: String
    var createdAt: Int
}

final class OAuth2TokenStorage {
    private let userDefaults = UserDefaults.standard
    var token: String? {
        get {
            let bearerToken = userDefaults.string(forKey: "bearerToken")
            return bearerToken
        }
        set {
            userDefaults.set(newValue, forKey: "bearerToken")
            print("Bearer Token set")
        }
    }
}

final class OAuth2Service {
    private enum NetworkError: Error {
        case codeError
    }

    func fetchOAuthToken(code: String?, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        var urlComponents = URLComponents(string: Constants.unsplashAuthoriseTokenURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
            ]
        let requestURL = urlComponents.url!
        print(requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                }
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.codeError))
            }
            if let data = data {
                print(String(data: data, encoding: .utf8))
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                        completion(.success(response.accessToken))
                } catch let error {
                    print("token error")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
