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
    
    var cashName: [String:String] = [
        "Euro": "EUR",
        "Dollar": "USD",
        "Livre sterling": "GBP",
        "Yen": "JPY"]
    
    func dictionnaryCash() {
        for (nameCash, valuesCash) in cashName {
            print("\(nameCash) mesure \(valuesCash)m")
        }
    }
    //    let nameKeys = [String](cashName.keys)
    //    let nameValues = [String](cashName.values)
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
        
        CashService.shared.getCash() { result in
            switch result {
            case .success(let cashResult):
                DispatchQueue.main.async {
                    print(cashResult)
                    guard let text = self.firstAmountCash.text, let value = Double(text)
                    else { return }
                    
                    self.firstCash.text = self.cashName.updateValue("Euro", forKey: "EUR")
                    //                    self.firstCash.text = cashResult.rates[String: value(forKey: "EUR")]
                    self.firstAmountCash.text = String(cashResult.convert(value: value, from: "EUR", to: "USD"))
                    
                    //                DispatchQueue.main.async {
                    //                    self.firstCash.text = String(cashResult.base)
                    //                    self.firstAmountCash.text = "1"
                    //                    print("success")
                }
            case .failure(let error):
                //                self.alertMessage(title: "Erreur", message: "impossible d'afficher la monnaie, verifier votre connexion internet")
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateCashTwo() {
        
        CashService.shared.getCash() { result in
            switch result {
            case .success(let cashResult):
                DispatchQueue.main.async {
                    guard let text = self.firstAmountCash.text, let value = Double(text)
                    else { return }
                    //                    self.secondCashPickerView = cashName[String: "Euro"]?
                    
                    //                    var selectedCash = self.cashName.keys
                    //
                    //                    self.secondCashPickerView = (result: cashResult.convert(value: value, from: self.cashName[0] ??, to: "EUR"))
                    //                    [cashName.secondCashPickerView.selectedRow(inComponent: 0))
                    //                    let selectedCash = self.secondCashPickerView.selectedRow(inComponent: 0)
                    
                    self.secondAmountCash.text = String(cashResult.convert(value: value, from: "EUR", to: "USD"))
                    
                    //                    self.secondCash.text = cashResult.rates.first?.key
                    
                    self.secondCash.text = self.cashName.debugDescription
                    
                    print("-> ici", cashResult.convert(value: value, from: "EUR", to: "USD"))
                    print(cashResult)
                    //                DispatchQueue.main.async {
                    ////                    self.secondCash.text = String(cashResult.base)
                    //                    self.secondAmountCash.text = cashResult.rates.debugDescription
                    //                    print("success")
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
        return cashName.keys.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(cashName.keys.sorted()[row])
    }
}

