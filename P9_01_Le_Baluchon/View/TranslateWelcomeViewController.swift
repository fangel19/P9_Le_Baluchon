//
//  TranslateWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class TranslateWelcomeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var firstLanguage: UILabel!
    @IBOutlet weak var firstTappedLanguage: UITextField!
    
    @IBOutlet weak var secondLanguage: UIStackView!
    @IBOutlet weak var secondTranslateLanguage: UITextField!
    
    @IBAction func translate(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
