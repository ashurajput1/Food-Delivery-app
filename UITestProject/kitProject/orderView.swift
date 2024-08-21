//
//  orderView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 03/08/24.
//

import SwiftUI

struct orderView: View {
    @StateObject var loader = imageLoader()
    @StateObject var viewModel = orderListViewModel()
    @EnvironmentObject var userOrderList:UserOrderList
    @Binding var isVisible:Bool
    let itemDetail: MenuItem
    var body: some View {
        VStack {
            Image(uiImage: loader.image)
                .resizable()
                .frame(width: 300,height: 200)
                .onAppear{
                    loader.loadImage(urlString: itemDetail.imageURL)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            Text(itemDetail.name)
                .fontWeight(.semibold)
                .font(.system(size: 30))
                .padding(20)
            Text(itemDetail.description)
                .font(.system(size: 20,weight: .regular))
                .frame(width: 300, alignment: .center)
            HStack(spacing:30){
                VStack(spacing:10) {
                    Text("Carolie")
                    Text("\(itemDetail.calories)")
                }
                VStack(spacing:10) {
                    Text("Carbs")
                    Text("\(itemDetail.carbs)")
                }
                VStack(spacing:10) {
                    Text("Protein")
                    Text("\(itemDetail.protein)")
                }
            }
            .padding()
            Spacer()
            Button(action: {
                userOrderList.userOrderList.append(itemDetail)
                UserdefaultManager.shared.saveData(model: userOrderList.userOrderList, key: "orderList")
                viewModel.checkOrder(id: itemDetail.id)
            }, label: {
                if viewModel.isPresent {
                    Text("Thank you for ordering")
                        .modifier(ButtonStyleModifierr())
                } else {
                    Text("\(String(format: "%.2f", itemDetail.price))$ - Add to Order")
                        .modifier(ButtonStyleModifier())
                }
            })
            .disabled(viewModel.isPresent)
        }
        .frame(width:320,height: 500)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .onAppear(perform: {
            viewModel.checkOrder(id: itemDetail.id)
            if viewModel.isPresent {
                print("Already Present in the Bucket")
            }
        })
        .overlay(alignment: .topTrailing) {
            Button(action: {
                isVisible = false
            }, label: {
                Image(systemName: "multiply.circle")
                    .resizable()
                    .foregroundColor(.black)
            })
            .frame(width: 30,height: 30)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
}
class orderListViewModel:ObservableObject {
    @Published var isPresent = false
    func checkOrder(id:Int) {
        if let orderList  = UserdefaultManager.shared.retriveData(key: userDefaultKeys.orderList) as [MenuItem]?  {
            if orderList.contains(where: { $0.id == id }) {
                isPresent = true
                return
            }
        }
        isPresent = false
    }
}
struct ButtonStyleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
//            .fontWeight(.medium)
            .frame(width: 250, height: 50)
            .font(.system(size: 20))
            .foregroundColor(.white)
            .background(Color.darkGreen)
            .cornerRadius(10)
    }
}
struct ButtonStyleModifierr: ViewModifier {

    func body(content: Content) -> some View {
        content
//            .fontWeight(.medium)
            .frame(width: 250, height: 50)
            .font(.system(size: 20))
            .foregroundColor(.black)
    }
}


        

#Preview {
    orderView(isVisible: .constant(true), itemDetail: MenuItem(price: 8.99, calories: 300, id: 1, carbs: 0, protein: 14, name: "Asian Flank Steak", imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/asian-flank-steak.jpg", description: "This perfectly thin cut just melts in your mouth."))
}
