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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTappedLanguage.delegate = self
        secondTranslateLanguage.delegate = self
        updateLanguage()
        
        
        // Do any additional setup after loading the view.
    }
    
//    private var language: String = ["EN", "FR"]
    

    private func updateLanguage() {
        
        guard self.firstTappedLanguage.text != nil else { return }
        
        TranslateService.shared.postTranslate(language: firstTappedLanguage.text!) { result in
            switch result {
            case .success(let translateResult):
                
                DispatchQueue.main.async {
                    self.secondTranslateLanguage.text = translateResult.data.translations[0].translatedText
                }
            case .failure:
                
                self.alertMessage(title: "Erreur", message: "impossible d'afficher la selection, verifier votre connexion")
                print("error")
            }
        }
    }
//    private  func updateLanguageTwo()  {
//        TranslateService.shared.postTranslate(language: secondTranslateLanguage.text!) { result in
//            switch result {
//            case .success(let translateResult):
//
//                DispatchQueue.main.async {
//                        self.firstTappedLanguage.text =  translateResult.data.translations[0].translatedText
//                }
//            case .failure:
//
//                self.alertMessage(title: "Erreur", message: "affichage impossible")
//            }
//        }
//    }
    
//    private func updateTranslateTwo(to: String, toFR: Bool) {
//
//        TranslateService.shared.postTranslate(language: "EN") { result in
//            switch result {
//            case .success(let translateResult):
//                DispatchQueue.main.async {
//
//                    guard let text = self.firstTappedLanguage.text, let value = String(text)
//                    else { return }
//
//                    if !toFR {
//
//                        self.firstTappedLanguage(result: translateResult.data.translations(value: value, from: "EUR", to: to), toSecondCash: true)
//                        self.secondCash.text = to
//
//                    } else {
//                        let selectedCash = self.secondCashPickerView.selectedRow(inComponent: 0)
//                        let cashList = self.cashName.keys.sorted()
//                        guard let list = self.cashName[cashList[selectedCash]] else { return }
//                        self.resultWithTwoDecimal(result: cashResult.convert(value: value, from: list, to: "EUR"), toSecondCash: false)
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            //                DispatchQueue.main.async {
//            //                    self.alertMessage(title: "Erreur", message: "impossible d'afficher la monnaie, verifier votre connexion internet")
//            //                }
//            }
//        }
//    }
//
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //    MARK: - Action button validate
    
    @IBAction func translate(_ sender: Any) {
        updateLanguage()
//        updateLanguageTwo()
    }
}
