//
//  thirdViewModel.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 01/08/24.
//

import Foundation
import SwiftUI


class thirdViewModel:ObservableObject{
    @Published var itemsArray:[MenuItem] = []
    @Published var itemDetail:MenuItem? = nil
    @Published var isOrderViewPresent:Bool = false
    
}
