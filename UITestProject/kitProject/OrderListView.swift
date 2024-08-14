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
        List {
            ForEach(userorderList.userOrderList) { itemDetails in
                Listcell(itemData: itemDetails)
            }
            .onDelete(perform: userorderList.delete)
        }
        .onAppear(perform: {
            if let orderList  = UserdefaultManager.shared.retriveData(key: "orderList") as [MenuItem]?  {
                userorderList.userOrderList = orderList
            }
        })
    }
}

//#Preview {
//    OrderListView()
//               .environmentObject(UserOrderList())
//}
