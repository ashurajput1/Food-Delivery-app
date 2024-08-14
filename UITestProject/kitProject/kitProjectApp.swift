//
//  kitProjectApp.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 27/07/24.
//

import SwiftUI

@main
struct kitProjectApp: App {
    var userOrderlist = UserOrderList()
    var body: some Scene {
        WindowGroup {
           ContentView()
                .environmentObject(userOrderlist)
        }
    }
}
