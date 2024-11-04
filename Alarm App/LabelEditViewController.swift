//
//  LabelEditViewController.swift
//  Alarm App
//
//  Created by Supraja on 04/11/24.
//

import UIKit

class LabelEditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelTextField: UITextField!
    var label: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        labelTextField.becomeFirstResponder()
        self.labelTextField.delegate = self
        
        labelTextField.text = label
        labelTextField.returnKeyType = UIReturnKeyType.done
        labelTextField.enablesReturnKeyAutomatically = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        label = textField.text ?? ""
        performSegue(withIdentifier: Identifier.labelUnwindIdentifier, sender: self)
        return false
    }
}
