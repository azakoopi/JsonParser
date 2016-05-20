//
//  Parser.swift
//  JsonParser
//
//  Created by Ashwani Choudhary on 20/05/16.
//  Copyright © 2016 Ashwani Choudhary. All rights reserved.
//

import UIKit
import AFNetworking
import OLGhostAlertView

class Parser: NSObject {

    // Response Handler Declared
    var ServiceResponse: ((response: NSDictionary?, error: NSError?) -> Void)?

    // Declared Session
    var client: AFHTTPSessionManager?

    // MARK: Initialize Class
    class func sharedParser() -> Parser {

        let sharedInstance: Parser = Parser()

        return sharedInstance
    }

    // MARK: GET Request
    // Get Request
    func getDataFrom_URL(urlString: String, completion: (response: NSDictionary?, error: NSError?) -> Void) {
        self.ServiceResponse = completion
        self.startFetching_withURL(urlString)
    }

    func startFetching_withURL(urlString: String) {

        client = AFHTTPSessionManager(sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        client!.requestSerializer = AFJSONRequestSerializer()
        client!.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")

        client?.GET(urlString, parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, res: AnyObject?) -> Void in
            print(res)

            if (res as? NSDictionary) != nil {
                self.ServiceResponse!(response: res as? NSDictionary, error: nil)
            }
            else {
                print("Invalid")

                self.showMessage("Invalid Json", yourMessage: "Please Validate", time: 3.0)

            }

            }, failure: { (task: NSURLSessionDataTask?, err: NSError) in
            print(err)
        })

    }

    // MARK: Alert
    func showMessage(titleMessage: String, yourMessage: String, time: NSTimeInterval) {

        let poper: OLGhostAlertView = OLGhostAlertView(title: titleMessage, message: yourMessage, timeout: time, dismissible: false)
        poper.position = .Bottom
        poper.topContentMargin = 64.0
        poper.style = .Dark
        poper.completionBlock = { () -> Void in
            self.ServiceResponse!(response: nil, error: nil)
        }
        let window: UIWindow! = UIApplication.sharedApplication().keyWindow
        poper.showInView(window)

    }

}
