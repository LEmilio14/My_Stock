//
//  StockManager.swift
//  MyStocks
//
//  Created by Emilio Guerrero on 11/22/20.
//

import UIKit

protocol StockManagerDelegate {
    func didUpdatePrice(_ stockManager: StockManager, info: StockModel)
    func didFailWithError(error: Error)
}

struct StockManager {
    
    var delegate: StockManagerDelegate?
    
    let stockTimeArray = ["day", "week", "month"]

    let baseURL = "https://api.polygon.io/v2/aggs/ticker"
    let apiKey = "eAPVeMvPhSePRI4ONx5j0m42auEcveci"
    
    func getStockTime(for stockTime: String, for stockSymbol: String) {
        let timeSelected = stockTime
        let symbolEntered = stockSymbol
        let urlString = "\(baseURL)/\(symbolEntered)/range/1/\(timeSelected)/2020-11-01/2020-11-22?apikey=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let stock = self.parseJason(safeData) {
                        //print(stock.open)
                        //print(stock.close)
                        self.delegate?.didUpdatePrice(self, info: stock)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJason(_ data: Data) -> StockModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(StockData.self, from: data)
            let resultsSize = decodedData.resultsCount
            let openPrice = decodedData.results[resultsSize - 1].o
            let closePrice = decodedData.results[resultsSize - 1].c
            let stockFetched = StockModel(open: openPrice, close: closePrice)
            return stockFetched
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
