//
//  LoginViewModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/6/22.
//

import Foundation


class LoginViewModel: ObservableObject {
      @Published var credentials = Credentials()
      

    
       var loginDisabled: Bool {
           credentials.email.isEmpty || credentials.password.isEmpty
       }
       
    func login(completion: @escaping (Bool) -> Void) async {

           
         try?  await APIService.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, APIService.APIError>) in

               switch result {
                   case .success:
                       
                       completion(true)
                   case .failure:
                       credentials = Credentials()
             
                       completion(false)
               }
           }
       }
}
