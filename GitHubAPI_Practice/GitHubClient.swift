//
//  GitHubClient.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import Foundation

typealias GitHubCompletionHandler<T> = (Result<T,GitHubError>) -> Void

enum GitHubError: Error {
    case error(String)
}

class GitHubClient {
    static func fetchData(keyword: String,
                          completion: @escaping GitHubCompletionHandler<[Repository]>) {
        var urlOption = "?q=\(keyword)"
        if keyword.isEmpty {
            urlOption += "swift"
        }
        guard let url = URL(string: "https://api.github.com/search/repositories\(urlOption)") else {
            completion(.failure(.error("urlが存在しません")))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
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
