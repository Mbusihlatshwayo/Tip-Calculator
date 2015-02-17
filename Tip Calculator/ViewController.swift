//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Mbusi Hlatshwayo on 2/14/15.
//  Copyright (c) 2015 Mbusi Hlatshwayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipPercentSlider: UISlider!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var customSplitSlider: UISlider!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: ".15")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // inputTextField is selected so the keyboard is displayed every time the view loads
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.delegate = self
    }
    // hide the keyboard when done using 
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        //billAmountTextField.resignFirstResponder()
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let inputString = billAmountTextField.text // get the user input
        
        // convert the slider value to an NSDecimalNumber
        let sliderValue = NSDecimalNumber(integer: Int(customTipPercentSlider.value))
        
        // convert the split slider value to a NSNumber
        let splitSliderValue = NSDecimalNumber(integer: Int(customSplitSlider.value))
        
        // get the tip %
        let customPercent = sliderValue / decimal100
        
        // did the slider generate the event?
        if sender is UISlider {
            //slider moved update the labels with the new custom tip percent
            customTipPercentLabel1.text = NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: NSNumberFormatterStyle.PercentStyle)
            
            customTipPercentLabel2.text = customTipPercentLabel1.text
            
            //display number of people in label
            splitLabel.text = NSNumberFormatter.localizedStringFromNumber(splitSliderValue, numberStyle: NSNumberFormatterStyle.NoStyle)
        }
        
        // if there is a bill amount calculate the tip and total
        if !inputString.isEmpty {
            // convert to NSDecimalNumber and insert the decimal point
            let billAmount = (NSDecimalNumber(string: inputString) / decimal100)
            // the bill amount split between number of people
            let splitBillAmount = (NSDecimalNumber(string: inputString) / decimal100) / splitSliderValue
            
            
            
            // did the text field generate the event?
            if sender is UITextField {
                // update billAmountLabel with currency-formatted total
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                }
            // calculate and display the constant 15% tip and total
            let fifteenTip = (billAmount * decimal15Percent) / splitSliderValue
            tip15Label.text = formatAsCurrency(splitBillAmount * decimal15Percent)
            total15Label.text = formatAsCurrency(splitBillAmount + fifteenTip)

            // calculate the custom tip and display the custom tip and total
            let customTip = splitBillAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text = formatAsCurrency(splitBillAmount + customTip)

        }
        else { // clear the labels
            billAmountLabel.text = ""
            tip15Label.text = ""
            total15Label.text = ""
            totalCustomLabel.text = ""
            tipCustomLabel.text = ""
        }
    }
}

// convert number value to currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

// overloaded + operator to add NSDecimal nubers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

// overloaded * operator to multiply NSDecimal numbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

// overladed / operator to divide NSDecimal numbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}