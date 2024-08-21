//
//  OrderListView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 08/08/24.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var userorderList:UserOrderList
    var body: some View {
        ZStack
        {
            List {
                ForEach(userorderList.userOrderList) { itemDetails in
                    Listcell(itemData: itemDetails)
                }
                .onDelete(perform: userorderList.delete)
            }
            emptyStateView()
                .opacity(userorderList.emptyList ? 1:0)
        }
        .onAppear(perform: {
            if let orderList  = UserdefaultManager.shared.retriveData(key: userDefaultKeys.orderList) as [MenuItem]?  {
                userorderList.userOrderList = orderList
            }
            if userorderList.userOrderList.count == 0 {
                userorderList.emptyList = true
            } else {
                userorderList.emptyList = false
            }
        })
    }
}

#Preview {
    OrderListView()
               .environmentObject(UserOrderList())
}
