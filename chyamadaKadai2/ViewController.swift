//
//  ViewController.swift
//  chyamadaKadai2
//
//  Created by toaster on 2021/06/15.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var firstField: UITextField!
    @IBOutlet private weak var secondField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var Operator: UISegmentedControl!
    @IBOutlet private weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        Operator.setTitle("+", forSegmentAt: 0)
        Operator.setTitle("-", forSegmentAt: 1)
        Operator.setTitle("×", forSegmentAt: 2)
        Operator.setTitle("÷", forSegmentAt: 3)
    }
}

@objc extension ViewController{
     private func calculate(){
        var sum :Int
        let firstNumber = Int(firstField.text ?? "") ?? 0
        let secondNumber = Int(secondField.text ?? "") ?? 0
        
        switch Operator.selectedSegmentIndex{
            case 0:sum = firstNumber + secondNumber
            case 1:sum = firstNumber - secondNumber
            case 2:sum = firstNumber * secondNumber
            case 3:
                if secondNumber == 0 {
                    resultLabel.text = "割る数には０以外を入力してください"
                    return
                } else {
                    sum = firstNumber / secondNumber
                }
            default:return
        }
        resultLabel.text = String(format: "%.1f", sum)
    }
}

/* 当初行おうとしていたのは配列操作関数による実装
 
---class---
private var textField:[UITextField]{
    [firstField,secondField]
}

---extentsion---
状態として演算子を持つのは型を揃えられないため困難
 
@objc extension ViewController{
     func didChangeOperator(){
        switch Operator.selectedSegmentIndex {
        case 0: state = "+"
        case 1: state = "-"
        case 2: state = "*"
        case 3: state = "%"
        default: break
        }
    }
}

---extension--
配列操作関数で可能かと思ったけれど加算と同様にはうまくはいかない
減算の場合は初期値から第一引数を引き、次いで第二引数を引くため引数同士の差し引きではなくなる
乗除の場合も同様
 
@objc extension ViewController{
     private func calculate(){
        var optionalSum:Int?
        switch Operator.selectedSegmentIndex{
            case 0:optionalSum = textField.map{Int($0.text ?? "") ?? 0}.reduce(0,+)
            case 1:optionalSum = textField.map{Int($0.text ?? "") ?? 0}.reduce(0,-)
            case 2:optionalSum = textField.map{Int($0.text ?? "") ?? 0}.reduce(0,*)
            case 3:optionalSum = textField.map{Int($0.text ?? "") ?? 0}.reduce(0,*)
            default:print("selectedSegmentIndex外です")
        }
        
        guard let sum = optionalSum else {
            return
        }
        resultLabel.text = sum.description
    }
}
 */
