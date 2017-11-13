//
//  ViewController.swift
//  FB Search
//
//  Created by  Mac  on 2017/4/9.
//  Copyright © 2017年 CSCI 571. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBAction func Clear(_ sender: Any) {
        TextField.text = ""
    }
    @IBAction func Search(_ sender: Any) {
        var keyword : String = TextField.text!
        Keyword.sharedInstance.keyword = keyword
        
        /*
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStoryboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        */
        
    }
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var keyword : String = TextField.text!
        Keyword.sharedInstance.keyword = keyword
        
        
      //  let searchresult : SearchResult = segue.destination as! SearchResult
        
              //searchresult.key = keyword
        
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view, typically from a nib.
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]!) {
        var userLocation:CLLocation = locations[locations.count - 1 ] as! CLLocation
        Keyword.sharedInstance.lon = userLocation.coordinate.longitude;
        Keyword.sharedInstance.lat = userLocation.coordinate.latitude;
        //print(Keyword.sharedInstance.lat)
        //print(Keyword.sharedInstance.lon)
    }


}

