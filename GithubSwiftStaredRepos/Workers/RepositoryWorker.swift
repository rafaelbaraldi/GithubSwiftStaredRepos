//
//  Worker.swift
//  GithubSwiftStaredRepos
//
//  Created by Rafael Baraldi on 19/04/19.
//  Copyright © 2019 Rafael Baraldi. All rights reserved.
//

import Foundation
import Alamofire

let searchURL = "https://api.github.com/search/repositories"

class RepositoryWorker {
    
    static func fetchRepositories(forLanguage language: String,
                                  withSortingType sortingType: String,
                                  atPage page: Int,
                                  withSuccessHandler successHandler: @escaping (([Repository]) -> ()),
                                  andFailureHandler failureHandler: @escaping ((String) -> ())) {
        
        let urlPamarameters = "q=language:\(language)&sort=\(sortingType)&page=\(page)"
        Alamofire.request("\(searchURL)?\(urlPamarameters)").responseData { (response) in
            if let jsonData = response.result.value,
                let repoResponse = try? JSONDecoder().decode(RepositorySearchResponse.self, from: jsonData) {
                successHandler(repoResponse.items)
                return
            }
            failureHandler("Sistema indisponível no momento")
        }
    }
}
