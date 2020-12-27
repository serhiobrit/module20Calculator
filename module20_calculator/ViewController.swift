//
//  ViewController.swift
//  module20_calculator
//
//  Created by Serhio Brit on 16.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var plusMinus: UIButton!
    
    var stillTyping = false // false - не первое значение введено, true - первое вместо 0 на экране
    var firstNumber: Double = 0 // предыдущее значение
    var secondNumber: Double = 0 // второе значение
    var currentNumber: Double { // текущее значение на дисплее
        get {
            return Double (result.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                result.text = valueArray[0]
            } else {
                result.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    var operationSign: String = "" // знак операции
    var dotWasPressed = false
    
    
    @IBAction func digitsButtonPress(_ sender: UIButton) {  // нажатие на кнопку с цифрой
        let number = sender.currentTitle!
        print(number)
        
        if stillTyping {
            if result.text?.count ?? 0 < 20 {
                if result.text == "0" {
                    result.text = number
                } else{
                    result.text = result.text! + number
                }
            }
        } else {
            result.text = number
            stillTyping = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func acPress(_ sender: UIButton) { // обнуление введенного значения
        firstNumber = 0
        secondNumber = 0
        currentNumber = 0
        result.text = "0"
        stillTyping = false
        operationSign = ""
        dotWasPressed = false
    }
    
    @IBAction func changeSignPress(_ sender: UIButton) { // изменить знак значения
        //        result.text = String(-Int(result.text!)!)
        currentNumber = -currentNumber
    }
    
    @IBAction func operation(_ sender: UIButton) {       // нажата кнопка операции
        operationSign = sender.currentTitle!
        firstNumber = currentNumber
        stillTyping = false
        dotWasPressed = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentNumber = operation(firstNumber, secondNumber)
        stillTyping = false
    }
    
    @IBAction func equalPressed(_ sender: UIButton) { // нажато равно
        if stillTyping {
            secondNumber = currentNumber
        }
        dotWasPressed = false
        
        switch operationSign {
        case "+": operateWithTwoOperands{$0 + $1}
        case "-": operateWithTwoOperands{$0 - $1}
        case "×": operateWithTwoOperands{$0 * $1}
        case "÷": operateWithTwoOperands{$0 / $1}
        default: break
        }
    }
    
    
    @IBAction func procentPressed(_ sender: UIButton) { // процент от числа
        if firstNumber == 0 {
            currentNumber = currentNumber / 100
        } else {
            secondNumber = firstNumber * currentNumber / 100
        }
    }
    
    @IBAction func dotPressed(_ sender: UIButton) { // точка
        if stillTyping && !dotWasPressed {
            result.text = result.text! + "."
            dotWasPressed = true
        } else if !stillTyping && !dotWasPressed {
            result.text = "0."
        }
    }
    
}
