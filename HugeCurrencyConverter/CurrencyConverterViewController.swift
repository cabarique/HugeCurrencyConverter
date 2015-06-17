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
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var inputCurrency: UITextField!
    @IBOutlet weak var currencySymbol: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("count")
        return self.currencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("entra")
        let cell = self.currencyTableView.dequeueReusableCellWithIdentifier("currencyCell") as UITableViewCell
        let currency = self.currencies[indexPath.row]
        println(currency.id)
        cell.textLabel!.text = currency.id
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        //tableView.beginUpdates()
        //tableView.endUpdates()
        
    }
}