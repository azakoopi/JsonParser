//
//  ViewController.swift
//  JsonParser
//
//  Created by Ashwani Choudhary on 20/05/16.
//  Copyright © 2016 Ashwani Choudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var textter: UITextView!

    override func viewDidLoad() {

        // Getting your URL request here
        let parser3: Parser = Parser.sharedParser()
        parser3.getDataFrom_URL("http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo", completion: { (response: AnyObject?, error: NSError?) -> Void in

            if (response != nil) { // If response is valid, do whatever yoiu want to do 🤓

                self.textter.text = "\(response)"
            }
            else { // If response is valid, do whatever yoiu want to do 😮

                self.textter.text = "Invalid Json Response"
            }
            self.myActivityIndicator.stopAnimating()

        })

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Unhide the Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

}

