//
//  StockData.swift
//  MyStocks
//
//  Created by Emilio Guerrero on 11/22/20.
//

import Foundation

struct StockData: Decodable {
    let resultsCount: Int
    let results: [Results]
}

struct Results: Decodable {
    let o: Double
    let c: Double
}
