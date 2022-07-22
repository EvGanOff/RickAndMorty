//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func getCharacters(page: Int, completion: @escaping (Result<[Characters], RMErrors>) -> Void)
    func getCharactersInfo(number: Int, completed: @escaping (Result<Characters, RMErrors>) -> Void)
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)

}

class NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()

    init () {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func getCharacters(page: Int, completion: @escaping (Result<[Characters], RMErrors>) -> Void) {
        let endpoint = baseURL + "/character?page=\(page)"

        // 2) Создание GET запроса (URL)
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidData))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 5) Обработать полученную информацию
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let characters = try self.decoder.decode(Results.self, from: data).results
                completion(.success(characters))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func getCharactersInfo(number: Int, completed: @escaping (Result<Characters, RMErrors>) -> Void) {
        let endpoint = baseURL + "/character/\(number)"
        // https://rickandmortyapi.com/api/character/2

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidData))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let characters = try self.decoder.decode(Characters.self, from: data)
                completed(.success(characters))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }

        task.resume()
    }
}
