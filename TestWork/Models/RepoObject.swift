//
//  RepoObject.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepoObject: NSObject {
    var repoName: String? //Repo name
    var repoDescription: String? //Repo description
    var numberOfForks: Int? //Number of repo forks
    var numberOfSubscribers: Int? //Number of repo subscribers
    var ownerLogin: String? //Owner login
    var ownerAvatarUrl: String? //Owner avatar
    
    init(parse repoJSON: JSON) {
        self.repoName = repoJSON["name"].stringValue
        self.repoDescription = repoJSON["description"].stringValue
        self.numberOfForks = repoJSON["forks"].intValue
        self.numberOfSubscribers = repoJSON["watchers_count"].intValue
        self.ownerLogin = repoJSON["owner"]["login"].stringValue
        self.ownerAvatarUrl = repoJSON["owner"]["avatar_url"].stringValue
    }
}
