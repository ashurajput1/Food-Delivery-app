//
//  orderView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 03/08/24.
//

import SwiftUI

struct orderView: View {
    @StateObject var loader = imageLoader()
    @EnvironmentObject var userOrderList:UserOrderList
    let itemDetail: MenuItem
    var body: some View {
        VStack {
            Image(uiImage: loader.image)
                .resizable()
                .frame(width: 300,height: 200)
                .onAppear{
                    loader.loadImage(urlString: itemDetail.imageURL)
                }
            Text("Test Appitizer")
                .fontWeight(.semibold)
                .font(.system(size: 30))
                .padding(20)
            Text("This is the order Details of the dish.its yummy and healthy")
                .font(.system(size: 20,weight: .regular))
                .frame(width: 300, alignment: .center)
            HStack(spacing:30){
                VStack(spacing:10) {
                    Text("Carolie")
                    Text("99")
                }
                VStack(spacing:10) {
                    Text("Carbs")
                    Text("99")
                }
                VStack(spacing:10) {
                    Text("Protein")
                    Text("99")
                }
            }
            .padding()
            Spacer()
            Button(action: {
                userOrderList.userOrderList.append(itemDetail)
                UserdefaultManager.shared.saveData(model: userOrderList.userOrderList, key: "orderList")
            }, label: {
                Text("$9.99 - Add to Order")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(.white)

                    .frame(width: 300,height: 55)
                    .background(Color.darkGreen)
                    .cornerRadius(10)
            })
            
        }
        .frame(width:320,height: 500)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

        

#Preview {
    orderView(itemDetail: MenuItem(price: 8.99, calories: 300, id: 1, carbs: 0, protein: 14, name: "Asian Flank Steak", imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/asian-flank-steak.jpg", description: "This perfectly thin cut just melts in your mouth."))
}
