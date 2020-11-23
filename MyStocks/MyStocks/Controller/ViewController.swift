//
//  ViewController.swift
//  MyStocks
//
//  Created by Emilio Guerrero on 11/20/20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, StockManagerDelegate{

    @IBOutlet weak var stockSymbolTextField: UITextField!
    @IBOutlet weak var stockTimePicker: UIPickerView!
    @IBOutlet weak var stockPicker: UIPickerView!

    var stockManager = StockManager()
    var openValue: Double = 0.0
    var closeValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockPicker.dataSource = self
        stockPicker.delegate = self
        stockSymbolTextField.delegate = self
        stockManager.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        stockSymbolTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "results", sender: self)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stockManager.getStockTime(for: stockManager.stockTimeArray[row], for: stockSymbolTextField.text!)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stockManager.stockTimeArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stockManager.stockTimeArray.count
    }
    
    func didUpdatePrice(_ stockManager: StockManager, info: StockModel) {
        print(info.close)
        DispatchQueue.main.async {
            self.openValue = info.open
            self.closeValue = info.close
        }
        print("Value fetched \(info.close)")
        print("Value fetched \(info.open)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if segue.identifier == "results" {
            
            let destinationVC = segue.destination as! StockResultViewController
            print(closeValue)
            destinationVC.symbolPassed = stockSymbolTextField.text!
            destinationVC.openStock = String(format: "%.2f", closeValue)
            destinationVC.closeStock = String(format: "%.2f", openValue)
            //destinationVC.closeResult.text = String(format: "%.2f", closeValue)
            //destinationVC.openResult.text = String(format: "%.2f", openValue)
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

