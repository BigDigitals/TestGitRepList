//
//  AlamofireManager.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlamofireManager: NSObject {
    typealias booleanCompletionHandler = (Bool, String?) -> Swift.Void
    typealias objectCompletionHandler = (Any, String?) -> Swift.Void
    
    public static let SharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
}

// MARK: Repo search

extension AlamofireManager {
    class func searchRepos(with name: String, and page: Int, completionHandler: objectCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.repoSearch
        
        let parameters = [
            "q": name,
            "sort" : "stars",
            "order" : "desc",
            "page" : NSNumber(integerLiteral: page)
            ] as [String : Any]
        
        SharedManager.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            if result["incomplete_results"].boolValue {
                completionHandler!(false, result["message"].stringValue)
            } else {
                var repos = [RepoObject]()
                for repoJSON in result["items"].arrayValue {
                    let repo = RepoObject(parse:repoJSON)
                    repos.append(repo)
                }
                completionHandler!(repos, nil)
            }
        }
    }
}

// MARK: Repo Subscribers

extension AlamofireManager {
    class func getRepoSubscribers(forRepo repo: String, user login: String, and page: Int, completionHandler: objectCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.repo + "/\(login)/\(repo)" + apiEndpoints.subscribers
        
        let parameters = [
            "page" : NSNumber(integerLiteral: page)
            ] as [String : Any]
        
        SharedManager.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            print(result)
            if result["incomplete_results"].boolValue {
                completionHandler!(false, result["message"].stringValue)
            } else {
                var subscribers = [SubscriberObject]()
                for subscriberJSON in result.arrayValue {
                    let repo = SubscriberObject(parse:subscriberJSON)
                    subscribers.append(repo)
                }
                completionHandler!(subscribers, nil)
            }
        }
    }
}
