//
//  OrderViewModel.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 21/08/24.
//

import Foundation


class OrderViewModel:ObservableObject {
    @Published var totalBill:Double?
    func calculateBill(for items: [MenuItem]) {
        var bill: Double = 0
        for item in items {
            bill += item.price
        }
        totalBill = bill
    }
}
