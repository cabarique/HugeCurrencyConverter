//
//  AppDelegate.swift
//  HugeCurrencyConverter
//
//  Created by luis cabarique on 6/16/15.
//  Copyright (c) 2015 Cabarique Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var currencies = [Currency]()
    var base = "USD"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        println(window)
        let url = NSURL(string: "http://api.fixer.io/latest?base=\(base)")
        var done = dispatch_semaphore_create(0);
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                if let parseJSON = json {
                    //println(parseJSON)
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    let ratesArray = parseJSON["rates"] as NSDictionary
                    for (rateName, rate) in ratesArray {
                        let currency = Currency(id: rateName as String, rate: rate as Double)
                        self.currencies.append(currency)
                    }
                    
                    let currencyController = self.window?.rootViewController as CurrencyConverterController
                    currencyController.currencies = self.currencies
                    
                    dispatch_semaphore_signal(done);
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    dispatch_semaphore_signal(done);
                }
            }
        }
        
        task.resume()
        dispatch_semaphore_wait(done, DISPATCH_TIME_FOREVER);
        return true
    }
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("entro")
        let itemDetailViewController = segue.destinationViewController as CurrencyConverterController
        itemDetailViewController.currencies = self.currencies
        
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

