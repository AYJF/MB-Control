//
//  ServiceApi.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/2/22.
//

import Foundation


class APIService  {
    
    var user = User()
    var promoModel:PromoOptions?
    var models:Models?
    var users:UserModel?
  
    enum APIError: Error {
        case error
    }
    
    
    func createPromoter(name:String, models:[[String : Any]], phone:String,
                        email:String, contactByEmail:Bool, contactByPhone:Bool, 
                        completion: @escaping (Result<Bool,APIError>) -> Void) async throws  {
        
        
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["name":name, "models": models,
                          "phone":phone, "userEmail":user.email,
                          "email":email, "contactByEmail":true, "contactByPhone":false] as [String : Any]
        
        //create the url with NSURL
        guard  let url = URL(string: "https://mb-control.azurewebsites.net/promoter") else {
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
        
        let token = "Bearer \(user.token)"
        
        print(token)
        
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(token, forHTTPHeaderField:"Authorization" )
    
        let (_, response) = try await URLSession.shared.data(for: request)

        
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            print("OK")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(true))
            }
        }
        else {
            print("Error while fetching data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(APIError.error))
            }
        }

    }
    
    
    func getModels( completion: @escaping (Result<Bool,APIError>) -> Void) async throws {
        
        //create the url with NSURL
        guard  let url = URL(string: "https://mb-control.azurewebsites.net/models") else {
            print("Invalid URL")
            return
        }
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = "Bearer \(user.token)"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(token, forHTTPHeaderField:"Authorization" )
    
        let (data, response) = try await URLSession.shared.data(for: request)

        print(token)
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            models = try JSONDecoder().decode(Models.self, from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(true))
            }
        }
        else {
            print("Error while fetching data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(APIError.error))
            }
        }
        
        
    }
    
    func getClients(completion: @escaping (Result<Bool,APIError>) -> Void) async throws {
        //create the url with NSURL
        guard  let url = URL(string: "https://mb-control.azurewebsites.net/client") else {
            print("Invalid URL")
            return
        }
        
 
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = "Bearer \(user.token)"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(token, forHTTPHeaderField:"Authorization" )
        
    
    
        let (data, response) = try await URLSession.shared.data(for: request)
        
    
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            users = try JSONDecoder().decode(UserModel.self, from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(true))
            }
        }
        else {
            print("Error while fetching data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(APIError.error))
            }
        }
    }
    
    
    //https://api.coindesk.com/v1/bpi/currentprice.json
    func getPromoOptions(credentials: Credentials,  completion: @escaping (Result<Bool,APIError>) -> Void) async throws {

        //create the url with NSURL
        guard  let url = URL(string: "https://mb-control.azurewebsites.net/promoteroptions") else {
            print("Invalid URL")
            return
        }
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST

        
        let token = "Bearer \(credentials.token)"

        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(token, forHTTPHeaderField:"Authorization" )
    
        let (data, response) = try await URLSession.shared.data(for: request)

        
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            print("OK")
            promoModel = try JSONDecoder().decode(PromoOptions.self, from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(true))
            }
        }
        else {
            print("Error while fetching data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(APIError.error))
            }
        }
        

 

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

        self.user = try JSONDecoder().decode(User.self, from: data)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.user.token != "" {
                completion(.success(true))
            } else {
                completion(.failure(APIError.error))
            }
        }
    }
}


