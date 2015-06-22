//
//  CurrencySelectorController.swift
//  HugeCurrencyConverter
//
//  Created by luis cabarique on 6/20/15.
//  Copyright (c) 2015 Cabarique Inc. All rights reserved.
//

import UIKit

class CurrencySelectorController: UITableViewController{
    
    var currencyList = AppDelegate.currencies.currencies
    let hugeColor = UIColor(red: 233/255, green: 71/255, blue: 131/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var color = UIColor(red: 249/255, green: 177/255, blue: 178/255, alpha: 1.0)
        self.tableView.separatorColor = color
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.currencyList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("currencyCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        var currency = currencyList[indexPath.row]
        cell.textLabel?.text = currency.id
        cell.detailTextLabel?.text = currency.name
        if(currency.favorite){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    /// Mark currency as favorite
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currencyItem = self.currencyList[indexPath.row]
        if(currencyItem.favorite){
            currencyItem.favorite = false
        }else{
            currencyItem.favorite = true
        }
        
        self.currencyList[indexPath.row] = currencyItem

        tableView.beginUpdates()

        let cell = tableView.dequeueReusableCellWithIdentifier("currencyCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = currencyList[indexPath.row].id
        
        tableView.endUpdates()

        tableView.reloadData()//reloads list
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let currencyToMove: Currency = self.currencyList[sourceIndexPath.row]
        self.currencyList.removeAtIndex(sourceIndexPath.row)
        self.currencyList.insert(currencyToMove, atIndex: destinationIndexPath.row)
    }
    
    /// removes delete from table edit
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    /// indents while editing
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    /// Allow to move rows
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /// sets currency list on view desappear
    override func viewWillDisappear(animated: Bool) {
        AppDelegate.currencies.currencies = currencyList
    }

}
