//
//  CurrencyConverterViewController.swift
//  HugeCurrencyConverter
//
//  Created by luis cabarique on 6/16/15.
//  Copyright (c) 2015 Cabarique Inc. All rights reserved.
//

import UIKit

class CurrencyConverterController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var currencies = [Currency]()
    var currentValue: Double! = 1
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var inputCurrency: UITextField!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var currencyCountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencies = AppDelegate.currencies.currencies
        var color = UIColor(red: 249/255, green: 177/255, blue: 178/255, alpha: 1.0)
        self.currencyTableView.separatorColor = color
        self.currencyTableView.opaque = true
        self.currencyTableView.backgroundView = nil
        self.currencyTableView.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    /// Get input currency value
    /// :param: sender
    @IBAction func valueChanged(sender: UITextField) {
        self.currentValue = (sender.text as NSString).doubleValue
        self.currencyTableView.reloadData()
    }
    
    /// Limits textField number of characters
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let length = count(textField.text.utf16) + count(string.utf16) - range.length
        
        return length <= 9
        
    }
    
    
    // MARK: - Table view data source
    /// tableview number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0;
        let favorites = self.currencies.filter { (temp) -> Bool in
            temp.favorite == true
        }
        return favorites.count
    }
    
    /// sets tableview image, text and detail text
    /// gets the USD rate by currecy rate to get the current exchage rate
    /// :param: tableView
    /// :param: indexPath
    /// :returns: cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.currencyTableView.dequeueReusableCellWithIdentifier("currencyCell") as! UITableViewCell
        let favorites = self.currencies.filter { (temp) -> Bool in
            temp.favorite == true
        }
        let currency = favorites[indexPath.row]
        //let currency = self.currencies[indexPath.row]
        let image = UIImage(named: "\(currency.id).png")
            
        cell.textLabel!.text = currency.id
        let rate = self.currentValue * currency.rate
        cell.detailTextLabel?.text = String(format:"%.3f", rate)
        cell.imageView?.image = image
        var label = cell.viewWithTag(110) as! UILabel
        label.text = currency.id
        //label.text = "\(label.frame.origin.x) \(label.frame.origin.y) \(currency.id)"
        //label.frame.origin = CGPoint(x: 15, y: 15)
        
        return cell
    }
    
    
    
    /// select cell and navigates to currency selector
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //tableView.beginUpdates()
        //tableView.endUpdates()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "currencyList" {
            let itemDetailViewController = segue.destinationViewController as! CurrencySelectorController
            itemDetailViewController.title = "Favorites"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.currencies = AppDelegate.currencies.currencies
        self.currencyTableView.reloadData()
    }

}