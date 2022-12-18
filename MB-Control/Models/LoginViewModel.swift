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
      @Published var models:Models?
      @Published var users:UserModel?
    @Published var promoters:PromoterModels?
  
      
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
    

    
    func createPromoter(name: String, models:[[String : Any]],
                        phone: String, email: String, contactByEmail: Bool, contactByPhone: Bool,
                        completion: @escaping (Bool) -> Void) async {
        
        try? await apiService.createPromoter(name: name, models: models,
                                             phone: phone, email: email,
                                             contactByEmail: contactByEmail,
                                             contactByPhone: contactByPhone)
        { [](result:Result<Bool, APIService.APIError>) in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
            
        }
    }
    
    func createClient(name:String, models:[[String : Any]], rfc:String, promterId:String,
                      completion: @escaping (Bool) -> Void) async {
        
        try? await apiService.createClients(name: name, models: models, rfc: rfc, promterId: promterId)
        { [](result:Result<Bool, APIService.APIError>) in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
            
        }
    }
    
    
    
    func getModels( ) async {
        try? await apiService.getModels() {  [unowned self](result:Result<Bool, APIService.APIError>) in
            
            switch result {
            case .success:
                models = apiService.models
            case .failure:
                models = nil
                
               
            }
        }
    }
    
    func getClients() async {
        try? await apiService.getClients() {  [unowned self](result:Result<Bool, APIService.APIError>) in
            
            switch result {
            case .success:
                users = apiService.users
            case .failure:
                users = nil
                
               
            }
        }
    }
    
    
    func getPromoters() async {
        try? await apiService.getPromoters() {  [unowned self](result:Result<Bool, APIService.APIError>) in
            
            switch result {
            case .success:
                promoters = apiService.promoters
            case .failure:
                promoters = nil
                
               
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
