//
//  AlertViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 22/06/2021.
//

import UIKit

extension UIViewController {
    
    func alertMessage(_ message: String) {
    let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
}
}
