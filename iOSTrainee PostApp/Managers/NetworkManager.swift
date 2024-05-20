//
//  NetworkManager.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import Foundation

//enum APIError: Error {
//    case failedToGetData
//    case text(String)
//}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    
    func getFeedOfPosts(completion: @escaping (Result<PostsModel, Error>) -> Void) {
        let apiUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
        
        guard let url = URL(string: apiUrl) else {
            print("invalid url...")
            return
        }
        
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(PostsModel.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
   

    func getSpecificPost(postId: Int, completion: @escaping (Result<SpecificPostModel, Error>) -> Void) {
        let apiUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(postId).json"
        
        guard let url = URL(string: apiUrl) else {
            print("invalid url...")
            return
        }
        
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let specificPost = try decoder.decode(SpecificPostModel.self, from: data)
                    completion(.success(specificPost))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
