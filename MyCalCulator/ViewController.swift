//
//  ViewController.swift
//  MyCalCulator
//
//  Created by Confiz on 28/07/2016.
//  Copyright © 2016 Confiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var calculatorDisply: UILabel!
    private var isInTheMiddleOfTyping = false;
    private var calBrain = CalcuatorBrain();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayValue: Double{
        get{
            return Double(calculatorDisply.text!)!;
        }
        set{
            calculatorDisply.text = String(newValue);
        }
    }

    @IBAction private func numericButtonPressed(sender: AnyObject) {
        let buttonPressed = sender.currentTitle!;
        let presentText = calculatorDisply.text!;
        if (!isInTheMiddleOfTyping)
        {
            calculatorDisply.text = buttonPressed;
            isInTheMiddleOfTyping = true;
        }
        else
        {
            calculatorDisply.text = presentText + buttonPressed!;
        }
    }
    @IBAction private func clearButtonPressed(sender: AnyObject) {
        
        calculatorDisply.text = "0"
        calBrain.setOperand(0.0);
    }
    
    @IBAction func operationButtonPressed(sender: AnyObject) {
        
        if (isInTheMiddleOfTyping){
            calBrain.setOperand(displayValue);
            isInTheMiddleOfTyping = false;
        }
        if let mathematicalSymbol = sender.currentTitle{
            calBrain.performOperation(mathematicalSymbol!);
            displayValue = calBrain.result;
            
        }
    }

}

