//
//  AddContactController.swift
//  ListContacts
//
//  Created by Shankar on 02/02/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import CoreData

class AddContactController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textPhonenumber: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlerToAddContact(_ sender: Any) {
        
        guard let name = textFieldName.text, name != "" else {
            showAlert(with: "Please enter name", title: "Error Alert")
            return
        }
        guard let phonenumber = textPhonenumber.text, phonenumber != "" else {
            showAlert(with: "Please enter phonenumber", title: "Error Alert")
            return
        }
        guard let email = textFieldEmail.text, email != "" else {
            showAlert(with: "Please enter email", title: "Error Alert")
            return
        }
        guard isValidEmail(email) else {
            showAlert(with: "Please enter valid email", title: "Error Alert")
            return
        }
         // Add the new contact to Core Data Context
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: DatabaseController.getContext())
        let newPlayer = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
        // Set the data to the entity
        newPlayer.setValue(name, forKey: "name")
        newPlayer.setValue(phonenumber, forKey: "number")
        newPlayer.setValue(email, forKey: "email")
        // Save them to Core Data
        DatabaseController.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(with message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(_ checkString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: checkString)
    }
}

extension AddContactController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > textField.text!.count {
            return false
        }
        if textPhonenumber == textField {
            let newLength = textField.text!.count + string.count - range.length
            
            if newLength == 10 && textField.returnKeyType == UIReturnKeyType.default {
                textField.returnKeyType = UIReturnKeyType.go
                textField.reloadInputViews()
            } else if textField.returnKeyType == UIReturnKeyType.go && newLength < 10 {
                textField.returnKeyType = UIReturnKeyType.default
                textField.reloadInputViews()
            }
            let characterSet = NSCharacterSet(charactersIn: "1234567890").inverted

            let filtered = string.components(separatedBy: characterSet).joined(separator: "")
            if string == filtered {
                return (newLength > 10) ? false : true
            } else {
                return false
            }
        }
        return true
    }
}
