//
//  ListViewController.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import Kingfisher

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var reposArray = [RepoObject]()
    var page = 0
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup TableView
        self.tableView.tableFooterView = UIView.init()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let vc = segue.destination as! RepoDetailViewController
            vc.repo = sender as! RepoObject
        }
    }
    
    // MARK: Data loading
    
    func loadData() {
        page = 0
        self.reposArray = [RepoObject]()
        loadNextPage()
    }
    
    func loadNextPage() {
        if !isLoading {
            isLoading = true
            page += 1
            MBProgressHUD.showAdded(to: (self.view)!, animated: true)
            AlamofireManager.searchRepos(with: searchBar.text!, and: page) { repos, error in
                if error == nil {
                    self.reposArray.append(contentsOf: repos as! [RepoObject])
                    self.tableView.reloadData()
                }
                MBProgressHUD.hide(for: (self.view)!, animated: true)
                self.isLoading = false
            }
        }
    }
}

// MARK: TableView Delegate and DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellIdentifier", for: indexPath) as! ListTableViewCell
        cell.accessibilityIdentifier = "ListCell_\(indexPath.row)"
        let repo = reposArray[indexPath.row]
        
        cell.repoNameLabel.text = repo.repoName
        cell.repoDescriptionLabel.text = repo.repoDescription
        cell.numberOfForksLabel.text = "Number of forks: \(repo.numberOfForks ?? 0)"
        cell.avatarImageView.kf.setImage(with: URL(string:repo.ownerAvatarUrl!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: reposArray[indexPath.row])
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

// MARK: SearchBar Delegate
extension ListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.loadData()
    }
}
