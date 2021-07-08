//
//  CashWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class CashWelcomeViewController: UIViewController,UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var firstCash: UILabel!
    @IBOutlet weak var firstAmountCash: UITextField!
    
    @IBOutlet weak var secondCash: UILabel!
    @IBOutlet weak var secondAmountCash: UITextField!
    @IBOutlet weak var secondCashPickerView: UIPickerView!
    
    //    MARK: - Properties
    
    let cashName = [
        "Euro",
        "Dollar",
        "Livre sterling"]
    //    let cashName = [
    //        "Euro": "EUR",
    //        "Dollar": "USD",
    //        "Livre sterling": "GBP"]
    
    //    MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondCashPickerView.delegate = self
        secondCashPickerView.dataSource = self
        secondCashPickerView.selectRow(0, inComponent: 0, animated: false)
        updateCashOne()
        updateCashTwo()
    }
    
    private func updateCashOne() {
        
        CashService.shared.getCash(cash: cashName[1]) { result in
            switch result {
            case .success(let cashResult):
                
                DispatchQueue.main.async {
                    self.firstCash.text = String(cashResult.base)
                    self.firstAmountCash.text = "1"
                    print("success")
                }
            case .failure:
                self.alertMessage(title: "Erreur", message: "impossible d'afficher la monnaie, verifier votre connexion internet")
                print("error")
            }
        }
    }
    
    private func updateCashTwo() {
        
        CashService.shared.getCash(cash: cashName[secondCashPickerView.selectedRow(inComponent: 0)]) { result in
            switch result {
            case .success(let cashResult):
                
                DispatchQueue.main.async {
                    self.secondCash.text = String(cashResult.base)
                    self.secondAmountCash.text = cashResult.rates.debugDescription
                    print("success")
                }
            case .failure:
                self.alertMessage(title: "Erreur", message: "impossible d'afficher la monnaie, verifier votre connexion internet")
            }
        }
    }
    
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    //    MARK: - Action
    
    @IBAction func changeCash(_ sender: Any) {
        updateCashTwo()
    }
}

//MARK: - Delegate

extension CashWelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cashName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cashName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(cashName[row])
    }
}
