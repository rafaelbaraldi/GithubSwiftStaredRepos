//
//  ViewController.swift
//  GithubSwiftStaredRepos
//
//  Created by Rafael Baraldi on 19/04/19.
//  Copyright © 2019 Rafael Baraldi. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var repoList: [Repository] = []
    
    var currentPage = 1
    var currentLanguage = "swift"
    var currentSortType = "stars"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.addInfiniteScroll { (tableView) -> Void in
            self.currentPage = self.currentPage + 1
            self.requestData()
            tableView.finishInfiniteScroll()
        }
        
        activityIndicator.startAnimating()
        requestData()
    }
    
    func requestData() {
        RepositoryWorker.fetchRepositories(forLanguage: currentLanguage,
                                           withSortingType: currentSortType,
                                           atPage: currentPage,
                                           withSuccessHandler: { (repositoyResponseList) in
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
            self.repoList.append(contentsOf: repositoyResponseList)
            self.tableView.reloadData()
            self.tableView.finishInfiniteScroll()
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    @objc func refreshData() {
        currentPage = 1
        RepositoryWorker.fetchRepositories(forLanguage: currentLanguage,
                                           withSortingType: currentSortType,
                                           atPage: currentPage,
                                           withSuccessHandler: { (repositoyResponseList) in
            self.repoList = repositoyResponseList
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") {
            cell.textLabel?.text = repoList[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
}
