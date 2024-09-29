//
//  TabView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            thirdView()
                .tabItem {
                                 Label("Home", systemImage: "house")
                        }
            OrderListView()
                .tabItem {
                    Label("order",systemImage: "iphone.smartbatterycase.gen2")
                }
            UserAccountDetailsView()
                .tabItem {
                    Label("Account", systemImage: "person.circle.fill")
                }
        }
       
    }
}
class UserOrderList:ObservableObject {
    @Published var userOrderList:[MenuItem] = []
    @Published var emptyList:Bool = true
    func delete(at offsets: IndexSet) {
        userOrderList.remove(atOffsets: offsets)
        UserdefaultManager.shared.saveData(model: userOrderList, key: "orderList")
        if userOrderList.count == 0 {
            emptyList = true
        } else {
            emptyList = false
        }
    }
}


#Preview {
    ContentView().environmentObject(UserOrderList())
}
