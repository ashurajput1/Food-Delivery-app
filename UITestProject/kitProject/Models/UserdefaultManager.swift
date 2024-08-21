//
//  UserdefaultManager.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 08/08/24.
//

import Foundation
import SwiftUI

class UserdefaultManager:ObservableObject {
    static let shared = UserdefaultManager()
    var userDefaultkeys = userDefaultKeys()
    func saveData<T: Codable>(model: T, key: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.setValue(data, forKey: key)
            print("successful")
        } catch {
            print("Failed to encode model: \(error)")
        }
    }
    func retriveData<T:Codable>(key:String) -> T? {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            // Decode the data into the specified type
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            print("Failed to decode data: \(error)")
            return nil
        }
    }
}
struct userDefaultKeys {
    
    static let userInfo = "userInfo"
    static let orderList = "orderList"
    
}
