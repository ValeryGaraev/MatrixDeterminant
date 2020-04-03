//
//  ViewController.swift
//  MatrixDeterminant
//
//  Created by Valery Garaev on 4/2/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(verticalStack)
        configureViews()
    }

    lazy var matrix = [[Int]]()
    lazy var determinant = 0
    lazy var solution = Solution()

    let textField: UITextField = {
        var textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.placeholder = "N"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.numberPad
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: CGFloat(integerLiteral: 100)).isActive = true
        textField.heightAnchor.constraint(equalToConstant: CGFloat(integerLiteral: 40)).isActive = true
        
        return textField
    }()
    
    let button: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.backgroundColor = .white
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let verticalStack: UIStackView = {
        var verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        return verticalStack
    }()
    
    let alert: UIAlertController = {
        var alert = UIAlertController(title: "Zero is not allowed", message: "Please enter a non-zero value to generate matrix and calculate its determinant", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    @objc private func buttonPressed(sender: UIButton!) {
        guard let size = Int(textField.text ?? "0"), size > 0 else {
            self.present(alert, animated: true) {
                self.textField.text = ""
            }
            return
        }
        
        button.isEnabled = false

        DispatchQueue.global(qos: .background).async {
            self.matrix = self.solution.generateMatrix(ofSize: size)
            
            print("Calculating determinant for matrix")
            
            for index in 0..<self.matrix.count {
                print(self.matrix[index])
            }
            
            self.determinant = self.solution.calculateDeterminant(ofMatrix: self.matrix, size: size)
        
            print("Determinant is: \(self.determinant)")
            self.matrix.removeAll()
            
            DispatchQueue.main.async {
                self.button.isEnabled = true
            }
        }
    }
    
    private func configureViews() {
        verticalStack.addArrangedSubview(textField)
        verticalStack.addArrangedSubview(button)
        verticalStack.setCustomSpacing(40.0, after: verticalStack.arrangedSubviews[0])
        verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

