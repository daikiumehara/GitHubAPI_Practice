//
//  Repository.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import Foundation

class Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let htmlUrl: String
}

class Repositorys: Codable {
    let items: [Repository]
}
