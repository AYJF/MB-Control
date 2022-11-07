//
//  ServiceApi.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/2/22.
//

import Foundation


class APIService {
    static let shared = APIService()
  
    enum APIError: Error {
        case error
    }

    
    
    func login(credentials: Credentials,
               completion: @escaping (Result<Bool,APIError>) -> Void) async throws {
        
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["email": credentials.email, "password": credentials.password]

        //create the url with NSURL
        guard  let url = URL(string: "https://mb-control.azurewebsites.net/users/login") else {
            print("Invalid URL")
            return
        }

        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print("error")
            print(error.localizedDescription)
           
        }

        

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        if (response as? HTTPURLResponse)?.statusCode == 200 {
            print("Ok")
        }
        else {
            print("Error while fetching data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(APIError.error))
            }
        }




        let user:User = try JSONDecoder().decode(User.self, from: data)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if user.token != "" {
                completion(.success(true))
            } else {
                completion(.failure(APIError.error))
            }
        }
    }
}


