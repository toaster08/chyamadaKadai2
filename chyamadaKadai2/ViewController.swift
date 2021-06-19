//
//  ViewController.swift
//  chyamadaKadai2
//
//  Created by toaster on 2021/06/15.
//
import Foundation
import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var firstField: UITextField!
    @IBOutlet private weak var secondField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var operatorSegment: UISegmentedControl!
    @IBOutlet private weak var calculateButton: UIButton!

    private var textFields: [UITextField] {
        [firstField, secondField]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }
}

@objc extension ViewController {
    private func calculate() {
        view.endEditing(true)

        let numbers = textFields.map { Double($0.text ?? "") ?? 0 }

        guard (2...).contains(numbers.count) else { return }

        let first = numbers.first!
        let rest = numbers.dropFirst()

        if operatorSegment.selectedSegmentIndex == 3 && rest.contains(0) {
            resultLabel.text = "割る数には０以外を入力してください"
            return
        }

        let calculation: (Double, Double) -> Double

        switch operatorSegment.selectedSegmentIndex {
        case 0:
            calculation = (+)
        case 1:
            calculation = (-)
        case 2:
            calculation = (*)
        case 3:
            calculation = (/)
        default:
            return
        }

        resultLabel.text = String(format: "%.1f", rest.reduce(first, calculation))
    }
}
