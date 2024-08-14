//
//  Models.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 03/08/24.
//

import Foundation


struct MenuItem: Codable,Identifiable {
    let price: Double
    let calories: Int
    let id: Int
    let carbs: Int
    let protein: Int
    let name: String
    let imageURL: String
    let description: String
}

