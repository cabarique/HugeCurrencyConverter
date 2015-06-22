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
    var base = "USD" //Current base is USD
    let latestCurrencyURL : String = "http://api.fixer.io/latest?base=USD" //latest currency rates url
    let currenciesNAmesURL : String = "http://openexchangerates.org/currencies.json" //currency names
    
    struct currencies {//currency arrays
        static var currencies = [Currency]()
        static var currenciesNames = NSDictionary()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Just send a request and call the when finished closure
        func sendRequest(url: String, whenFinished: () -> Void) {
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            let task  = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
                (data, response, error) -> Void in
                whenFinished()
                    //println(request.URL)
                    //println(NSString(data: data, encoding: NSUTF8StringEncoding))
                var err: NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                
                if(err != nil) {
                    println(err!.localizedDescription)
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                }
                else {
                    if(url == self.latestCurrencyURL){
                        self.didGetLatestCurrency(json)
                    }else if(url == self.currenciesNAmesURL){
                        self.didGetCurrencyNames(json)
                    }
                }
                
                
            })
            task.resume()
        }
        
        let urls = [currenciesNAmesURL,latestCurrencyURL]
        
        var fulfilledUrls: Array<String> = []
        
        let group = dispatch_group_create();
        
        for url in urls {
            dispatch_group_enter(group)
            
            sendRequest(url, {
                () in
                fulfilledUrls.append(url)
                dispatch_group_leave(group)
            })
            
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        return true
    }
    
    /// did get latest currency values
    func didGetLatestCurrency(response: NSDictionary!){
        if let parseJSON = response {
            // Okay, the parsedJSON is here, let's get the value for 'rates' out of it
            let ratesArray = parseJSON["rates"] as! NSDictionary
            for (rateName, rate) in ratesArray {
                let id = rateName as! NSString
                var favorite = false
                if(id == "GBP" || id == "EUR" || id == "JPY" || id  == "BRL"){//default currencies
                    favorite = true
                }
                let currencyName = currencies.currenciesNames.valueForKey(id as String) as! String
                
                var currency = Currency(id: id as! String, rate: rate as! Double, favorite: favorite, name: currencyName as String)
                currencies.currencies.append(currency)
            }
        }
        else {
            // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
            println("Error could not parse JSON")
        }
    }
    
    /// did get currency names
    func didGetCurrencyNames(response: NSDictionary!){
        var currenciesTemp = currencies.currencies
        if let parseJSON = response {
            // Okay, the parsedJSON is here, let's get the value for 'rates' out of it
            let ratesArray = parseJSON as NSDictionary
            currencies.currenciesNames = ratesArray
        }
        else {
            // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
            println("Error could not parse JSON")
        }
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

