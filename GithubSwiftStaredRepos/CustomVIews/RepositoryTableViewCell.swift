//
//  RepositoryTableViewCell.swift
//  GithubSwiftStaredRepos
//
//  Created by Rafael Baraldi on 19/04/19.
//  Copyright © 2019 Rafael Baraldi. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var starsAmmount: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerAvatar: UIImageView!

    var repository: Repository? {
        didSet {
            repositoryName.text = repository?.name
            starsAmmount.text = "\(repository?.stargazers_count ?? 0) estrelas"
            ownerName.text = repository?.owner.login
        }
    }
}
