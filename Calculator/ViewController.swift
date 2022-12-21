//
//  ViewController.swift
//  Calculator
//
//  Created by Katharos on 21/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperaions: Operation?
    
    enum Operation {
        case add, subtract, multiply, devide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 2, height: buttonSize))
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(zeroPressed), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        let decimalPoint = UIButton(frame: CGRect(x: zeroButton.frame.width, y: holder.frame.size.height - buttonSize, width: buttonSize, height: buttonSize))
        decimalPoint.backgroundColor = .white
        decimalPoint.setTitle(",", for: .normal)
        decimalPoint.setTitleColor(.black, for: .normal)
        decimalPoint.tag = 11
        holder.addSubview(decimalPoint)
        
        for x in 0..<3 {
            let buttonSize: CGFloat = view.frame.size.width / 4
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
            button1.backgroundColor = .white
            button1.setTitle("\(x + 1)", for: .normal)
            button1.setTitleColor(.black, for: .normal)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        for x in 0..<3 {
            let buttonSize: CGFloat = view.frame.size.width / 4
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
            button2.backgroundColor = .white
            button2.setTitle("\(x + 4)", for: .normal)
            button2.setTitleColor(.black, for: .normal)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button2)
        }
        
        for x in 0..<3 {
            let buttonSize: CGFloat = view.frame.size.width / 4
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize, height: buttonSize))
            button3.backgroundColor = .white
            button3.setTitle("\(x + 7)", for: .normal)
            button3.setTitleColor(.black, for: .normal)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        clearButton.backgroundColor = .white
        clearButton.setTitle("AC", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        holder.addSubview(clearButton)
        
        let percentButton = UIButton(frame: CGRect(x:  clearButton.frame.width, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        percentButton.backgroundColor = .white
        percentButton.setTitle("%", for: .normal)
        percentButton.setTitleColor(.black, for: .normal)
        holder.addSubview(percentButton)
        
        let deleteButton = UIButton(frame: CGRect(x: clearButton.frame.width * 2, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        deleteButton.backgroundColor = .white
        deleteButton.setTitle("Del", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.addTarget(self, action: #selector(deletePressed(_:)), for: .touchUpInside)
        holder.addSubview(deleteButton)
        
        let operations = ["=", "/", "x", "-", "+"]
        
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
            button4.backgroundColor = .orange
            button4.setTitle("\(operations[x])", for: .normal)
            button4.setTitleColor(.white, for: .normal)
            button4.tag = x + 1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            holder.addSubview(button4)
        }
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
        // Actions
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperaions = nil
        firstNumber = 0
    }
    
    @objc func zeroPressed() {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func decimalPressed(_ sender: UIButton) {
        
    }
    
    @objc func deletePressed(_ sender: UIButton) {
        if let text = resultLabel.text, text.count > 1, resultLabel.text != "0" {
            resultLabel.text = String(text.dropLast())
            firstNumber = Int(text)!
        } else {
            resultLabel.text = "0"
            currentOperaions = nil
            firstNumber = 0
        }
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        } else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
                firstNumber = value
        }
        
        if tag == 1 {
            if let operation = currentOperaions {
                var secondNumber = 0
                
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                // Equal button pressed
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    firstNumber = result
                    break
                    
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    firstNumber = result
                    break
                    
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    firstNumber = result
                    break
                    
                case .devide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    firstNumber = result
                    break
                }
            }
            currentOperaions = nil
        } else if tag == 2 {
            currentOperaions = .devide
            resultLabel.text = ""
        } else if tag == 3 {
            currentOperaions = .multiply
            resultLabel.text = ""
        } else if tag == 4 {
            currentOperaions = .subtract
            resultLabel.text = ""
        } else if tag == 5 {
            currentOperaions = .add
            resultLabel.text = ""
        }
    }
    
}

