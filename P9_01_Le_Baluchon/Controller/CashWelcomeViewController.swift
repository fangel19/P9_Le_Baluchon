//
//  CashWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 10/06/2021.
//

import UIKit

class CashWelcomeViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var firstCash: UILabel!
    @IBOutlet weak var firstAmountCash: UITextField!
    @IBOutlet weak var firstCashPickerView: UIPickerView!
    
    
    @IBOutlet weak var secondCash: UILabel!
    @IBOutlet weak var secondAmountCash: UITextField!
    @IBOutlet weak var secondCashPickerView: UIPickerView!
    
//    var cashList = CashInfo()
//
    @IBAction func changeCash(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    private func updateCash() {
        CashService.shared.getCash(cash: "EUR") { result  in
            switch result {
            case .success(let cash):
                DispatchQueue.main.async {
                    self.viewCash(info: cash)
                    print(cash)
                }
            case .failure:
                self.alertMessage(with: "error")
            }
        }
    }
    private func viewCash(info: CashInfo)
    {
        firstAmountCash.text = String(info.base)
        secondAmountCash.text = String(info.base)
        //        firstCash.text = info.rates[String: Double]
    }
}
//extension CashWelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return CashInfo
//    }
//}
