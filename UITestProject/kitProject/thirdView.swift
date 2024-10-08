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
        ZStack {
            List(viewModel.itemsArray) { itemData in
                Listcell(itemData: itemData)
                    .onTapGesture {
                        viewModel.itemDetail = itemData
                        viewModel.isOrderViewPresent = true
                    }
            }
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2, anchor: .leading)
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
            } else {
                
            }

        }

        .scrollIndicators(.never)
        .onAppear{
            NetworkManager.shared.fetchData(from:  "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers") { (result: Result<MenuResponse, Error>) in
                switch result
                {
                case .success(let response):
                    DispatchQueue.main.async {
                        viewModel.isLoading = false
                        viewModel.itemsArray = response.request
                    }
                  
                case .failure(let error):
                    print(error)
                }
               
            }
        }
        .sheet(isPresented:$viewModel.isOrderViewPresent, content: {
            orderView(isVisible: $viewModel.isOrderViewPresent, itemDetail: viewModel.itemDetail!)
        })
    }
}

#Preview {
   thirdView(viewModel: thirdViewModel())
}
