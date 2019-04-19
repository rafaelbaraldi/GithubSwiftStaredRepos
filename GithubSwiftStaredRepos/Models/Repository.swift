//
//  File.swift
//  GithubSwiftStaredRepos
//
//  Created by Rafael Baraldi on 19/04/19.
//  Copyright © 2019 Rafael Baraldi. All rights reserved.
//

import Foundation

struct RepositorySearchResponse: Codable {
    
    var items: [Repository]
}

struct Repository: Codable {
    
    var name: String
    var stargazers_count: Int
    var owner: RepositoryOwner
}

struct RepositoryOwner: Codable {
    
    var login: String
    var avatar_url: String
}
