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
}
