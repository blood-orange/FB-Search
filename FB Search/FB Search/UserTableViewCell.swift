//
//  UserTableViewCell.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/13.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userstar: UIButton!
    @IBOutlet weak var userlabel: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
