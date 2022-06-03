//
//  RemoteService.swift
//  
//
//  Created by Nick Crews on 6/2/22.
//

import Foundation

struct RemoteService {

    static let shared = RemoteService()

    private var baseComponents: URLComponents? {
        guard let baseURL = Environment.shared?.appEngine.rawValue else {
            return nil
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL

        return components
    }

    func fetch<T: Codable>(_ type: T.Type, with path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<T>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.error(.modelMismatch))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func fetch<T: Codable>(_ type: T.Type, with path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<[T]>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let models = try decoder.decode([T].self, from: data)
                    completion(.success(models))
                } catch {
                    completion(.error(.modelMismatch))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func fetch(path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<Data>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    private func request(path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<Data>) -> Void) {
        guard let baseComponents = baseComponents else {
            return
        }
        var components = baseComponents
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            completion(.success(data))
        }

        task.resume()
    }
}
