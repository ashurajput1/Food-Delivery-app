//
//  OrderListView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 08/08/24.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var userorderList:UserOrderList
    @StateObject var viewModel:OrderViewModel = OrderViewModel()
    var body: some View {
        ZStack
        {
            List {
                ForEach(userorderList.userOrderList) { itemDetails in
                    Listcell(itemData: itemDetails)
                }
                .onDelete(perform: { indexSet in
                    userorderList.delete(at: indexSet)
                    viewModel.calculateBill(for: userorderList.userOrderList)
                })
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
            viewModel.calculateBill(for: userorderList.userOrderList)
        })
        .overlay(alignment: .bottom) {
            Button(action: {
            }, label: {
                Text("\(String(format: "Total Bill - %.2f", viewModel.totalBill ?? 0)) $")
                    .modifier(ButtonStyleModifier())
                    .opacity(userorderList.emptyList ? 0:1)
            })
            .padding(.bottom,UIScreen.main.bounds.height * 0.04)
        }
        
    }
}

#Preview {
    OrderListView()
               .environmentObject(UserOrderList())
}
