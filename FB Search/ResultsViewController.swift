//
//  ResultsViewController.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/13.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit

class ResultsViewController: UITabBarController {

    
    
    //@IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favorite") {
            Keyword.sharedInstance.favsegue = true
        }
        
        else if(segue.identifier == "search") {
            Keyword.sharedInstance.favsegue = false
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
