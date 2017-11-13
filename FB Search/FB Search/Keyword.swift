//
//  Keyword.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/13.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

final class Keyword {
    
    private init() {}
    
    
    static let sharedInstance: Keyword = Keyword()
    
    
    var keyword = String()
    var lat = Double()
    var lon = Double()
    var favsegue : Bool = false

}
