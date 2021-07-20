//
//  CashWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class CashWelcomeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var firstCash: UILabel!
    @IBOutlet weak var firstAmountCash: UITextField! {
        didSet {
            firstAmountCash.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneTappedFirstAmount)))
        }
    }
    
    @IBOutlet weak var secondCash: UILabel!
    @IBOutlet weak var secondAmountCash: UITextField! {
        didSet {
            secondAmountCash.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneTappedSecondAmount)))
        }
    }
    
    @IBOutlet weak var secondCashPickerView: UIPickerView!
    
    //    MARK: - Properties
    
    var cashName: [String: String] = [
        "Dollar Canadien": "CAD",
        "Dollar": "USD",
        "Livre sterling": "GBP",
        "Yen": "JPY"]
    
    //    MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.firstCash.text = "EUR"
        self.secondCash.text = "Choisir une monnaie"
        secondCashPickerView.delegate = self
        secondCashPickerView.dataSource = self
        secondCashPickerView.selectRow(0, inComponent: 0, animated: false)
        firstAmountCash.delegate = self
        cashPickerViewFalse()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func doneTappedFirstAmount() {
        
        cashPickerViewFalse()
        firstAmountCash.resignFirstResponder()
    }
    
    @objc func doneTappedSecondAmount() {
        
        let selectedCash = self.secondCashPickerView.selectedRow(inComponent: 0)
        let cashList = self.cashName.keys.sorted()
//                    verifier avec guard let
        guard let list = self.cashName[cashList[selectedCash]] else { return }
        
        updateCashTwo(to: list, toEuro: true)
        secondAmountCash.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func cashPickerViewFalse() {
        
        let selectedCash = self.secondCashPickerView.selectedRow(inComponent: 0)
        let cashList = self.cashName.keys.sorted()
        guard let list = self.cashName[cashList[selectedCash]] else { return }
        
        updateCashTwo(to: list, toEuro: false)
    }
    
    private func updateCashTwo(to: String, toEuro: Bool) {
        
        CashService.shared.getCash() { result in
            switch result {
            case .success(let cashResult):
                DispatchQueue.main.async {
                    
                    guard let text = self.firstAmountCash.text, let value = Double(text)
                    else { return }
                    
                    if !toEuro {
                        
                        self.secondAmountCash.text = String(cashResult.convert(value: value, from: "EUR", to: to))
                        self.secondCash.text = to
                        
                        
                    } else {
                        let selectedCash = self.secondCashPickerView.selectedRow(inComponent: 0)
                        let cashList = self.cashName.keys.sorted()
                        guard let list = self.cashName[cashList[selectedCash]] else { return }

                        self.firstAmountCash.text = String(cashResult.convert(value: value, from: list, to: "EUR"))
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            //                DispatchQueue.main.async {
            //                    self.alertMessage(title: "Erreur", message: "impossible d'afficher la monnaie, verifier votre connexion internet")
            //                }
            }
        }
    }
    
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //    MARK: - Action
    
    @IBAction func changeCash(_ sender: Any) {
        cashPickerViewFalse()
    }
}

//MARK: - Delegate

extension CashWelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cashName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cashName.keys.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(cashName.keys.sorted()[row])
    }
}

