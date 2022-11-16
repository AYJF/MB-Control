//
//  LoginViewModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/6/22.
//

import Foundation

//
class LoginViewModel: ObservableObject {
      @Published var credentials = Credentials()
      @Published var promoData:PromoOptions!
      
       var apiService = APIService()
    
       var loginDisabled: Bool {
           credentials.email.isEmpty || credentials.password.isEmpty
       }
       
    func login(completion: @escaping (Bool) -> Void) async {

           
         try?  await apiService.login(credentials: credentials) { [unowned self](result:Result<Bool, APIService.APIError>) in

               switch result {
                   case .success:
                       credentials.token = apiService.user.token
                       completion(true)
                   case .failure:
                       credentials = Credentials()
             
                       completion(false)
               }
           }
       }
    
    
    func createPromoter(name: String, isPercent: Bool, value: Double, optionId: String,
                        phone: String, email: String, contactByEmail: Bool, contactByPhone: Bool,
                        completion: @escaping (Bool) -> Void) async {
        try? await apiService.createPromoter(name: name, isPercent: isPercent, value: value, optionId: optionId,
                                             phone: phone, email: email, contactByEmail: contactByEmail, contactByPhone: contactByPhone)  { [unowned self](result:Result<Bool, APIService.APIError>) in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
            
        }
    }
    
    
    func getPromoOptions()  async {
        try? await apiService.getPromoOptions(credentials: credentials) { [unowned self](result:Result<Bool, APIService.APIError>) in
            switch result {
                case .success:
                promoData = apiService.promoModel

                case .failure:
                  promoData = nil

            }
        }
     
    }
}
