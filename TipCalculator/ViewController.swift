//
//  ViewController.swift
//  TipCalculator
//
//  Created by Swethaa Rajasekaran on 9/19/16.
//  Copyright © 2016 Swethaa. All rights reserved.
//

import UIKit

/**
 * Main view controller for the iOS application
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billText: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var userDefaults : NSUserDefaults?
    var defaultTip : Double?
    let tipRates = [0.12, 0.15, 0.20]
    var roundingEnabled : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewDidAppear(animated: Bool) {
        userDefaults = NSUserDefaults.standardUserDefaults()
        defaultTip = userDefaults?.doubleForKey("defaultTip")
        for (index,tmp) in tipRates.enumerate() {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        
        roundingEnabled = userDefaults?.boolForKey("defaultRound")
        
        let defaultBgColorSliderValue = userDefaults?.floatForKey("defaultBackgroundColorSliderValue")
        if (defaultBgColorSliderValue != nil) {
            let newBackgroundColor = UIColor(hue: CGFloat(defaultBgColorSliderValue!), saturation: 0.9, brightness: 1.0, alpha: 2.0)
            self.view.backgroundColor = newBackgroundColor
            
            calculateTip(self)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * Hide keyboard on tapping anywhere on the app
     */
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    /**
     * Reset text fields when button is pressed
     */
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        billText.text?.removeAll()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let bill = Double(billText.text!) ?? 0
        let tip = bill * tipRates[tipControl.selectedSegmentIndex]
        var total = tip + bill
        if (roundingEnabled != nil && roundingEnabled == true)
        {
            total = round(total)
        }
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    
    
}



