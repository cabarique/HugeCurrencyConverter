//
//  CurrencyConverterViewController.swift
//  HugeCurrencyConverter
//
//  Created by luis cabarique on 6/16/15.
//  Copyright (c) 2015 Cabarique Inc. All rights reserved.
//

import UIKit

class CurrencyConverterController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var currencies = [Currency]()
    var currentValue: Double! = 1
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var inputCurrency: UITextField!
    @IBOutlet weak var currencySymbol: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Get input currency value
    /// :param: sender
    @IBAction func valueChanged(sender: UITextField) {
        self.currentValue = (sender.text as NSString).doubleValue
        self.currencyTableView.reloadData()
    }
    
    // MARK: - Table view data source
    /// tableview number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    /// sets tableview image, text and detail text
    /// gets the USD rate by currecy rate to get the current exchage rate
    /// :param: tableView
    /// :param: indexPath
    /// :returns: cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.currencyTableView.dequeueReusableCellWithIdentifier("currencyCell") as UITableViewCell
        let currency = self.currencies[indexPath.row]
        
        
        let image = UIImage(named: "\(currency.id).png")
        
        cell.textLabel!.text = currency.id
        let rate = self.currentValue * currency.rate
        cell.detailTextLabel?.text = String(format:"%.3f", rate)
        cell.imageView?.image = image
        
        return cell
    }
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        //tableView.beginUpdates()
        //tableView.endUpdates()
        
    }*/
}