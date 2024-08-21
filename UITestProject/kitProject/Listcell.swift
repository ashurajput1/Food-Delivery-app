//
//  populateData.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 30/07/24.
//

import SwiftUI

struct Listcell: View {
    var itemData:MenuItem
    
    var body: some View {
        HStack
        {
            imgView(urlString: itemData.imageURL)
            VStack(alignment:.leading) {
                Text("\(itemData.name)")
                    .fontWeight(.medium)
                Text("\(itemData.description)")
                    .fontWeight(.light)
                    .font(.system(size: 15))
            }
           
        }
        .frame(height: 80)
        
    }
}
class imageLoader:ObservableObject {
    @Published var image:UIImage = UIImage()
    var urlString:String?
    func loadImage(urlString:String) {
        self.image = UIImage(named : "food placeholder")!
        guard let url = URL(string: urlString) else {
            return
        }
        NetworkManager.shared.downloadData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)!
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage(named: "food placeholder")!
                }
            }
            
        }
    }
    
}
struct imgView: View {
    @StateObject var loader = imageLoader()
    var urlString:String?
    var body: some View {
        
        Image(uiImage:loader.image)
            .resizable()
            .frame(width: 100,height: 75)
            .onAppear{
                DispatchQueue.main.async {
                    loader.loadImage(urlString: urlString!)
                }
                
            }
    }
}



struct cellData:Identifiable {
    var id: UUID?
    var Title:String?
    var cellImage:UIImage?
    var description:String?
}

#Preview {
    Listcell(itemData: MenuItem(price: 1, calories: 2, id: 3, carbs: 4, protein: 1, name: "new Dish", imageURL: "", description: "new dish from India,Uttar Pradesh"))
}
