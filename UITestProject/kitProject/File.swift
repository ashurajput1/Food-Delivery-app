//
//  File.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 28/07/24.
//

import Foundation
import SwiftUI

class viewModel:ObservableObject {
    @Published var a:String = ""
    
    
    func fetchData() async throws -> [User]? {
        do {
            var a = try await URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/users")! )
            return try JSONDecoder().decode([User].self, from: a.0)
        } catch {
            print("ashutosh chauhan")
        }
        return nil
    }
    
//    func count() {
//        a += 1
//    }
}

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
