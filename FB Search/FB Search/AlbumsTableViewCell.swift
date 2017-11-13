//
//  AlbumsTableViewCell.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/16.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
