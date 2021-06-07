//
//  GitHubClient.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import Foundation

enum GitHubError: Error {
    case error(String)
}

class GitHubClient {
    static func fetchData(completion: @escaping (Result<[Repository],GitHubError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=swift") else {
            completion(.failure(.error("urlが存在しません")))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
                completion(.failure(.error("通信エラーが発生しました")))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let datas = try decoder.decode(Repositorys.self, from: data!).items
                completion(.success(datas))
                return
            } catch {
                completion(.failure(.error("デコードでエラーが発生したよ")))
                return
            }
        }
        task.resume()
    }
}
