//
//  EventTableViewCell.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/15.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventimg: UIImageView!
    @IBOutlet weak var eventlabel: UILabel!
    @IBOutlet weak var eventstar: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
