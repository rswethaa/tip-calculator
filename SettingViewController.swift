//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Swethaa Rajasekaran on 9/25/16.
//  Copyright © 2016 Swethaa. All rights reserved.
//

import UIKit

/**
 * ViewController containing logic for all the settings changes
 */
class SettingViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var bgcolorSlider: UISlider!
    
    var userDefaults : NSUserDefaults?
    let defaultTip: Double? = nil
    var currentTip: Double? = nil
    let tipRates = [0.12, 0.15, 0.20]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1.7, animations: {
            self.tipControl.alpha = 5.0
            self.roundSwitch.alpha = 1.0
            self.bgcolorSlider.alpha = 1.0
        })

   
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        userDefaults = NSUserDefaults.standardUserDefaults()
        resetAllConfigToDefault()
    }
    
    func resetAllConfigToDefault() {
        resetTipToPersistedValue()
        resetRoundingToPersistedValue()
        resetBgColorSliderValue()
    }
    
    @IBAction func defaultRateModified(sender: AnyObject) {
        let currentTip = tipRates[tipControl.selectedSegmentIndex]
        
        userDefaults?.setDouble(currentTip, forKey: "defaultTip")
        userDefaults?.synchronize()
    }
    
    func resetTipToPersistedValue() {
        let persistedTipValue = userDefaults?.doubleForKey("defaultTip")
        print("DEBUG: Persisted value of tip : ", persistedTipValue)
        
        for (index,value) in tipRates.enumerate() {
            if(persistedTipValue == value){
                tipControl.selectedSegmentIndex = index
            }
        }
    }
    
    @IBAction func roundingToggled(sender: AnyObject) {
        userDefaults?.setBool(roundSwitch.on, forKey: "defaultRound")
        userDefaults?.synchronize()
    }
    
    func resetRoundingToPersistedValue() {
        let persistedRoundingValue = userDefaults?.boolForKey("defaultRound")
        if ((persistedRoundingValue) != nil && persistedRoundingValue == true) {
            roundSwitch.setOn(true, animated: true)
        } else {
            roundSwitch.setOn(false, animated: true)
        }
    }
    
    @IBAction func colorSliderModified(sender: AnyObject) {
        let sliderValue = bgcolorSlider.value
        self.view.backgroundColor = UIColor(hue: CGFloat(sliderValue), saturation: 0.9, brightness: 1.0, alpha: 2.0)
        userDefaults?.setFloat(sliderValue, forKey: "defaultBackgroundColorSliderValue")
    }
    
    func resetBgColorSliderValue() {
        let persistedBgColorSliderValue = userDefaults?.floatForKey("defaultBackgroundColorSliderValue")
        if (persistedBgColorSliderValue != nil) {
            bgcolorSlider.value = persistedBgColorSliderValue!;
            self.view.backgroundColor = UIColor(hue: CGFloat(bgcolorSlider.value), saturation: 0.9, brightness: 1.0, alpha: 2.0)
        }
    }
}