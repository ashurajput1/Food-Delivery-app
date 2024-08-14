//
//  fetchData.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 30/07/24.
//

import Foundation


//class fetchData:ObservableObject {
//    @Published var data:[]
//    
//    func traverseData(urlString:String) {
//        NetworkManager.shared.fetchData(from: urlString, ofType: [apiDataModel].Type) {  in
//            <#code#>
//        }
//        
//    }
//}


struct apiDataModel : Decodable {
    let protein : Int?
    let carbs : Int?
    let description : String?
    let name : String?
    let calories : Int?
    let price : Double?
    let imageURL : String?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case protein = "protein"
        case carbs = "carbs"
        case description = "description"
        case name = "name"
        case calories = "calories"
        case price = "price"
        case imageURL = "imageURL"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        protein = try values.decodeIfPresent(Int.self, forKey: .protein)
        carbs = try values.decodeIfPresent(Int.self, forKey: .carbs)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        calories = try values.decodeIfPresent(Int.self, forKey: .calories)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
