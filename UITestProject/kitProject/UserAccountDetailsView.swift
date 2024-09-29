//
//  UserAccountDetailsView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 08/08/24.
//

import SwiftUI
import CoreLocation

struct UserAccountDetailsView: View {
    @StateObject var validateInfo = ValidateInfo()
    @StateObject private var viewModel = LocationViewModel()
    @State var isAlertVisible = false
    @State var isMapVisible = false
    var body: some View {
        Form(content: {
            Section {
                TextField("Name", text: $validateInfo.userDetails.userName)
                TextField("Phone", text: $validateInfo.userDetails.PhoneNumber)
                TextField("Email", text: $validateInfo.userDetails.userEmail)
                Button(action: {
                    validateInfo.CheckInfo()
                        let userInformation = userInformation(userName: validateInfo.userDetails.userName,PhoneNumber: validateInfo.userDetails.PhoneNumber,userEmail: validateInfo.userDetails.userEmail,birthDate: validateInfo.userDetails.birthDate)
                        
                        UserdefaultManager.shared.saveData(model: userInformation, key: userDefaultKeys.userInfo)
                        isAlertVisible = true
                }, label: {
                    Text("Submit")
                        .tint(.darkGreen)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .multilineTextAlignment(.center)
                    
                })
            }
            .alert(isPresented: $isAlertVisible) {
                var alertMessage = "Submitted SuccessFully"
                var alertTitle = "Submit"
                if validateInfo.error != nil {
                    alertMessage = validateInfo.error?.alertMessage ?? ""
                    alertTitle = validateInfo.error?.alertTitle ?? ""
                }
               return Alert(
                                            title: Text(alertTitle),
                                            message: Text(alertMessage),
                                            primaryButton: .default(Text("OK")) {
                                                // Action for OK button
                                            },
                                            secondaryButton: .cancel {
                                                // Action for Cancel button
                                 
                    }
                )
                }
            Section {
                DatePicker("Date Of Birth", selection: $validateInfo.userDetails.birthDate, displayedComponents: .date)
            }
        })
        .onAppear(perform: {
            if let user  = UserdefaultManager.shared.retriveData(key: userDefaultKeys.userInfo) as userInformation? {
                validateInfo.userDetails.userName = user.userName
                validateInfo.userDetails.userEmail = user.userEmail
                validateInfo.userDetails.PhoneNumber = user.PhoneNumber
                validateInfo.userDetails.birthDate = user.birthDate
            }
            

        })
        .sheet(isPresented:$isMapVisible, content: {
            var f = CLLocationCoordinate2D(latitude: 100.7749, longitude: -122.4194)
            MaptView(isVisibleMap: $isMapVisible)
        })
    }
}
class ValidateInfo:ObservableObject {
    @Published var userDetails = userInformation()
    @Published var error:AlertError? = nil
    
    func CheckInfo() {
        if  userDetails.userName.isEmpty {
            error = .UserNameEmpty
        } else if userDetails.userEmail.isEmpty {
            error = .EmailEmpty
        } else if userDetails.PhoneNumber.isEmpty{
            error = .PhoneNoEmpty
        } else {
            error = nil
        }
        
    }
    
    
}
enum AlertError:Error {
    case UserNameEmpty,EmailEmpty,PhoneNoEmpty
    var alertMessage:String {
        var message = "SuccessFully Submitted"
        switch self {
        case .UserNameEmpty:
            message = "Username can't be empty"
            break
        case .PhoneNoEmpty:
            message = "PhoneNo can't be empty"
            break
        case .EmailEmpty:
            message = "Email can't be empty"
        }
        return message
    }
    var alertTitle:String {
        var Title = "SuccessFully Submitted"
        switch self {
        case .UserNameEmpty:
            Title = "Error"
            break
        case .PhoneNoEmpty:
            Title = "Error"
            break
        case .EmailEmpty:
            Title = "Error"
        }
        return Title
    }
}
struct userInformation: Codable {
    var userName:String = ""
    var PhoneNumber:String = ""
    var userEmail:String = ""
    var birthDate:Date = Date()
}


#Preview {
    UserAccountDetailsView()
}
