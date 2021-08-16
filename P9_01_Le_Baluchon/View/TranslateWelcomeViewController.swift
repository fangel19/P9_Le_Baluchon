//
//  TranslateWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class TranslateWelcomeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets

    @IBOutlet weak var firstLanguage: UILabel!
    @IBOutlet weak var firstTappedLanguage: UITextField!
    @IBOutlet weak var secondLanguage: UIStackView!
    @IBOutlet weak var secondTranslateLanguage: UITextField!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        firstTappedLanguage.delegate = self
        secondTranslateLanguage.delegate = self
    }
    
    private func updateLanguage() {
        
        guard self.firstTappedLanguage.text != nil else { return }
        
        TranslateService.shared.postTranslate(language: firstTappedLanguage.text!) { result in
            switch result {
            
            case .success(let translateResult):
                DispatchQueue.main.async {
                    
                    self.secondTranslateLanguage.text = translateResult.data.translations[0].translatedText
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    
                    self.alertMessage(title: "Erreur", message: "impossible d'afficher la selection, verifier votre connexion")
                    print("error")
                }
            }
        }
    }
   
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //    MARK: - Action button validate
    
    @IBAction func translate(_ sender: Any) {
        
        updateLanguage()
    }
}
