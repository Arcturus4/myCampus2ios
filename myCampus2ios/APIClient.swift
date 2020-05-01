//
//  NetworkClient.swift
//  myCampus2ios
//
//  Created by iosdev on 29.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

enum ClientError: Error {
    case responseError
    case jsonError
    case jsonDecodeError
}

struct APIClient {
    let baseURL : URL
    
    init(endp : String) {
        let URLstring = "https://mycampus-server.karage.fi\(endp)"
        guard let baseURL = URL(string: URLstring) else {fatalError()}
        
        self.baseURL = baseURL
    }
    
    func networkRequest(_ userModel:User, completion: @escaping(Result<User, ClientError>) -> Void) {
        do {
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(userModel)
            
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let data = data {// check for http errors
                    do {
                        let body = try JSONDecoder().decode(User.self, from: data)
                            print(body)
                    } catch {
                        print("There was an error parsing data:", error)
                    }
                }
                if let response = response {
                    print(response)
                }

            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
    }
}
