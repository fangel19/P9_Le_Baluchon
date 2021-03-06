//
//  UITextFielf+Toolbar.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 16/07/2021.
//

import UIKit

extension UITextField {
    
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
