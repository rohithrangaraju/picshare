//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Rohith on 05/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
