//
//  RepoDetailTableViewCell.swift
//  TestWork
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class RepoDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
