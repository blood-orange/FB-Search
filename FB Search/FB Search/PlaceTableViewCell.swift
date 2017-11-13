//
//  PlaceTableViewCell.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/15.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeimg: UIImageView!
    @IBOutlet weak var placelabel: UILabel!
    @IBOutlet weak var placestar: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
