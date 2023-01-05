//
//  ProfileService.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 04.01.2023.
//

import Foundation

final class ProfileService {
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastToken: String?
    
    func fetchProfile(token: String, completion: @escaping ((Result <Profile, Error>) -> Void)) {
        assert(Thread.isMainThread)
        if lastToken == token { return }
        task?.cancel()
        lastToken = token
        
        let url = Constants.defaultBaseURL!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                }
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(Constants.NetworkError.codeError))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ProfileResult.self, from: data)
                    let profile = Profile(profileInput: response)
                        completion(.success(profile))
                    self.task = nil
                    if error != nil {
                        self.lastToken = nil
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
}

struct ProfileResult: Decodable {
    var username: String
    var firstName: String
    var lastName: String
    var bio: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case firstName  = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}

struct Profile {
    let profileInput: ProfileResult
    var username: String {
        "@" + profileInput.username
    }
    var name: String {
        profileInput.firstName + profileInput.lastName
    }
    var bio: String {
        profileInput.bio
    }
}
