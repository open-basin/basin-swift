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
        guard let baseURL = Environment.shared?.chain.engine else {
            return nil
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL

        return components
    }

    private var token: String {
        Environment.shared?.bearerToken ?? ""
    }

    func fetch<T: DatastoreModel>(_ type: T.Type, path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<T>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    let options = DataDecoder.Options(json: json)
                    decoder.userInfo = [DataDecoder.Options.key: options]
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

    func fetch<T: DatastoreModel>(_ type: [T].Type, path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<[T]>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    if let dict = json as? [String: Any],
                        let items = dict["items"] {
                        let itemsData = try JSONSerialization.data(withJSONObject: items)
                        let itemsJson = try JSONSerialization.jsonObject(with: itemsData)
                        let options = DataDecoder.Options(json: itemsJson)
                        decoder.userInfo = [DataDecoder.Options.key: options]
                        let models = try decoder.decode([T].self, from: itemsData)
                        completion(.success(models))
                    } else {
                        completion(.error(.invalidInput))
                    }
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

    func fetchSet(path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<[Data]>) -> Void) {
        request(path: path, queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    if let dict = json as? [String: Any],
                        let items = dict["items"] as? [Any] {
                        var result = [Data]()
                        for item in items {
                            let itemData = try JSONSerialization.data(withJSONObject: item)
                            result.append(itemData)
                        }
                        completion(.success(result))
                    } else {
                        completion(.error(.invalidInput))
                    }
                } catch {
                    completion(.error(.modelMismatch))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    private func request(path: String, queryItems: [URLQueryItem], _ completion: @escaping (OBResult<Data>) -> Void) {
        guard let baseComponents = baseComponents else { return }

        var components = baseComponents
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else { return }

        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else {
                completion(.error(.badResponse))
                return
            }

            guard let data = data else {
                completion(.error(.badResponse))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}
