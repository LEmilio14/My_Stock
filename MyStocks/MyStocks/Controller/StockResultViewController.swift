//
//  StockResultViewController.swift
//  MyStocks
//
//  Created by Emilio Guerrero on 11/22/20.
//

import UIKit

class StockResultViewController: UIViewController {
    
    @IBOutlet weak var stockInfo: UILabel!
    @IBOutlet weak var openText: UILabel!
    @IBOutlet weak var openResult: UILabel!
    @IBOutlet weak var closeText: UILabel!
    @IBOutlet weak var closeResult: UILabel!
    
    var symbolPassed: String = "NONE"
    var openStock: String = "0.0"
    var closeStock: String = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(symbolPassed)
        stockInfo.text = symbolPassed
        
        openText.text = "The market for \(symbolPassed) open with value:"
        openResult.text = "$\(openStock)"
        
        closeText.text = "The market for \(symbolPassed) close with value:"
        closeResult.text = "$\(closeStock)"
    }
    
    /*func didUpdatePrice(_ stockManager: StockManager, info: StockModel) {
        DispatchQueue.main.async {
            print(info.open)
            print(info.close)
            self.openResult.text = String(format: "%.2f", info.open)
            
            self.closeResult.text = String(format: "%.2f", info.close)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }*/

}
