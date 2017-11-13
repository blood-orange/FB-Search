//
//  UserViewController.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/13.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var backmenu: UIBarButtonItem!
    
    @IBOutlet weak var TableView: UITableView!
    
    let userdefaults = UserDefaults.standard   //for user local storage
    var itemID :[String] = []
    var itemName : [String] = []
    var picurl : [String] = []
    
    var prepage = String()
    var nextpage = String()
    
    @IBAction func previous(_ sender: Any) {
        self.itemID  = []
        self.itemName  = []
        self.picurl = []
        
        parsedata(prepage)
    }
    
    @IBAction func Next(_ sender: Any) {
        self.itemID = []
        self.itemName  = []
        self.picurl  = []
        
        parsedata(nextpage)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.TableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        // Do any additional setup after loading the view.
        
        SwiftSpinner.show("Loading...")
        backmenu.target = revealViewController()
        backmenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        if(Keyword.sharedInstance.favsegue == false){
            var url = "http://cs-server.usc.edu:21828/getjson.php?keyword=\(Keyword.sharedInstance.keyword)&type=user"
        
            parsedata(url)
        }
        else{
            userdefaults.set(<#T##url: URL?##URL?#>, forKey: <#T##String#>)
        }
        
        SwiftSpinner.hide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:UserTableViewCell = TableView.cellForRow(at: indexPath) as! UserTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.userlabel.text = itemName[indexPath.row]
        let url = NSURL(string: picurl[indexPath.row])
        let data = NSData(contentsOf: (url as? URL)!)
        cell.userimg.image = UIImage(data: data as! Data)
        

        return cell
    }
    
    func parsedata(_ url: String)  {
        
        Alamofire.request(url).responseJSON { response in
            if let jsonData = response.result.value {
                //print("JSON: \(JSON)")
                
                let json = JSON(jsonData)
                //print(JSONdata)
                let data  = json["data"]
                let paging = json["paging"]
                for (key, users) in data{
                    //print(type(of: users["name"].stringValue))
                    self.itemName.append(users["name"].stringValue)
                    self.itemID.append(users["id"].stringValue)
                    self.picurl.append(users["picture"]["data"]["url"].stringValue)
                }
                
                self.nextpage = paging["next"].stringValue
                self.prepage = paging["previous"].stringValue
                //print(self.prepage)
                //print(self.nextpage)
                //print(self.itemName)
                //print(self.itemID)
            
            }
           
            self.TableView.reloadData()
            
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
