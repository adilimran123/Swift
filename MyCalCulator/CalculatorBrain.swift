//
//  CalculatorBrain.swift
//  MyCalCulator
//
//  Created by Confiz on 29/07/2016.
//  Copyright © 2016 Confiz. All rights reserved.
//

import Foundation


class CalcuatorBrain //Classes are pass by refernce in Swift
{
    private var accumulator: Double = 0.0
    
    func setOperand(operand:Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operations> = [
        "π" :   Operations.Constant(M_PI),
        "e":    .Constant(M_E),
        "cos":  .UniaryOperation(cos),
        "√":    .UniaryOperation(sqrt),
        "×":    .BinaryOperation({return $0 * $1}),
        "−":    .BinaryOperation({return $0 - $1}),
        "÷":    .BinaryOperation({return $0 / $1}),
        "=":    .Equals
    ]
    
    private enum Operations{
        case Constant(Double)
        case UniaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol:String){
        if let constant = operations[symbol]{
            switch constant {
            case Operations.UniaryOperation(let foo):
                accumulator = foo(accumulator)
            case Operations.BinaryOperation(let function):
                executebinary()
                pendingBinary = PendingBinaryOperationInformation(binaryFuncton: function, firstOperand: accumulator)
            case Operations.Constant(let value): accumulator = value
            case Operations.Equals:
                executebinary()
                
                
            }
        }
    }
    
    private func executebinary(){
        
        if (pendingBinary != nil){
            accumulator = pendingBinary!.binaryFuncton((pendingBinary!.firstOperand),accumulator)
            pendingBinary = nil
        }
    
    }
    
    private var pendingBinary:PendingBinaryOperationInformation?
    
    //Struct are similar to class but are passed by value 
    //Structs are not immidiately copied, until we mutate it 
    //Default initalizer of struct have all its vars as arguments
    
    struct PendingBinaryOperationInformation {
        var binaryFuncton: (Double, Double) -> Double
        var firstOperand: Double

    }
    
    var result: Double{
        get{
            return accumulator;
        }
        
    }
}