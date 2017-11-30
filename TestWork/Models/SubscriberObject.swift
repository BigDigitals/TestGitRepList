//
//  SubscriberObject.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubscriberObject: NSObject {
    var login: String? //User login
    var avatarUrl: String? //User avatar
    
    init(parse repoJSON: JSON) {
        self.login = repoJSON["login"].stringValue
        self.avatarUrl = repoJSON["avatar_url"].stringValue
    }
}
