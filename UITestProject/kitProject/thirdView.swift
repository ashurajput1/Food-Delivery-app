//
//  thirdView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 30/07/24.
//

import SwiftUI

struct thirdView: View {
    @StateObject var viewModel = thirdViewModel()
    var body: some View {
        List(viewModel.itemsArray) { itemData in
            Listcell(itemData: itemData)
                .onTapGesture {
                    viewModel.itemDetail = itemData
                    viewModel.isOrderViewPresent = true
                }
        }
        .onAppear{
            print("alkmsadlfm")
            NetworkManager.shared.fetchData(from:  "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers") { (result: Result<MenuResponse, Error>) in
                switch result
                {
                case .success(let response):
                    DispatchQueue.main.async {
                        viewModel.itemsArray = response.request
                    }
                  
                case .failure(let error):
                    print(error)
                }
            }
        }
        .sheet(isPresented:$viewModel.isOrderViewPresent, content: {
            orderView(itemDetail: viewModel.itemDetail!)
        })
    }
}

#Preview {
    thirdView()
}
