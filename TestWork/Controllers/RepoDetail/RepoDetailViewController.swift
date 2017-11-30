//
//  RepoDetailViewController.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import Kingfisher

class RepoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfSubscribers: UILabel!
    
    var subscribersArray = [SubscriberObject]()
    var page = 0
    var isLoading = false
    
    var repo:RepoObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if repo != nil {
            navigationItem.title = repo.repoName
            numberOfSubscribers.text = "Number of subscribers: \(repo.numberOfSubscribers ?? 0)"
            loadData()
        }
    }
    
    // MARK: Data loading
    
    func loadData() {
        page = 0
        self.subscribersArray = [SubscriberObject]()
        loadNextPage()
    }
    
    func loadNextPage() {
        if !isLoading {
            isLoading = true
            page += 1
            MBProgressHUD.showAdded(to: (self.view)!, animated: true)
            AlamofireManager.getRepoSubscribers(forRepo: repo.repoName!, user: repo.ownerLogin!, and: page){ subscribers, error in
                if error == nil {
                    self.subscribersArray.append(contentsOf: subscribers as! [SubscriberObject])
                    self.tableView.reloadData()
                }
                MBProgressHUD.hide(for: (self.view)!, animated: true)
                self.isLoading = false
            }
        }
    }
}

// MARK: TableView Delegate and DataSource
extension RepoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriberCellIdentifier", for: indexPath) as! RepoDetailTableViewCell
        
        let subscriber = subscribersArray[indexPath.row]
        cell.nameLabel.text = subscriber.login
        cell.avatarImageView.kf.setImage(with: URL(string:subscriber.avatarUrl!))
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 100 {
            loadNextPage()
        }
    }
}
