//
//  ProfileManageable.swift
//  Bankey
//
//  Created by Jose Sousa on 12/01/2023.
//

import Foundation

protocol ProfileManageable: AnyObject {
    
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case badUrl
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

class ProfileManager: ProfileManageable {
    
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)") else {
            DispatchQueue.main.async {
                completion(.failure(.badUrl))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }

                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                } catch {
                    completion(.failure(.decodingError))
                }
            }

        }.resume()
    }
}
