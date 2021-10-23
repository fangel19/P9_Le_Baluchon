//
//  TranslateWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class TranslateWelcomeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets

    @IBOutlet weak var firstTappedLanguage: UITextField!
    @IBOutlet weak var secondTranslateLanguage: UITextField!
    @IBAction func userTappedOnScreen(_ sender: Any) {
        dismissKeyboard()
    }
    @IBOutlet weak var validateButton: UIButton!
    
    // MARK: - Properties
        
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        firstTappedLanguage.delegate = self
        secondTranslateLanguage.delegate = self
        setUpSpinner()
    }
    
    // Loading switch validation button
    private func setUpSpinner() {
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: validateButton.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: validateButton.centerYAnchor).isActive = true
    }
    
    // Loading animation
    private func loadingLayout(isActive: Bool) {
        
        if isActive {
            
            spinner.startAnimating()
            
        } else {
            
            spinner.stopAnimating()
        }
    }
    
    private func loadingButton(show: Bool) {
        
        self.validateButton.isHidden = show
    }

    // Function to dismiss the keyboard
    private func dismissKeyboard() {
        firstTappedLanguage.resignFirstResponder()
    }
    
    private func updateLanguage() {
        
        loadingLayout(isActive: true)
        loadingButton(show: true)
        
        guard self.firstTappedLanguage.text != nil else { return }
        
        TranslateService.shared.postTranslate(language: firstTappedLanguage.text!) { [weak self] result in
            switch result {
            
            case .success(let translateResult):
                DispatchQueue.main.async {
                    
                    self?.loadingLayout(isActive: false)
                    self?.loadingButton(show: false)
                    self?.secondTranslateLanguage.text = translateResult.data.translations[0].translatedText
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    
                    self?.alertMessage(title: "Erreur", message: "impossible d'afficher la selection, verifier votre connexion")
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
    
    //    MARK: - Action button translate
    
    @IBAction func translate(_ sender: Any) {

        updateLanguage()
    }
}
