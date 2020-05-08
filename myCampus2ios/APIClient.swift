//
//  NetworkClient.swift
//  myCampus2ios
//
//  Created by iosdev on 29.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation
import UIKit

/*enum ClientError: Error {
 case responseError
 case jsonError
 case jsonDecodeError
 }*/

struct APIClient {
    let baseURL : URL
    
    // Initializing URL with endpoint and converting baseURL into a string
    init(endp : String) {
        let URLstring = "https://mycampus-server.karage.fi\(endp)"
        guard let baseURL = URL(string: URLstring) else {fatalError()}
        
        self.baseURL = baseURL
    }
    // Starting the URLSsession
    func networkRequest(_ userModel:User, completion: @escaping(Result<UserResponse, Error>) -> Void) {
        do {
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(userModel)
            // print(request.description)
            
            // Here, we are handling the data response and possible errors:
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let data = data {
                    do {
                        if let text = String(bytes: data, encoding: .utf8){
                            print(text)
                        }
                        // De
                        let body = try JSONDecoder().decode(UserResponse.self, from: data)
                        print(body.token)
                        DispatchQueue.main.async {
                            (UIApplication.shared.delegate as! AppDelegate).token = body.token
                        }
                    } catch {
                        print("There was an error parsing data:", error)
                    }
                }
                if let resp = response as? HTTPURLResponse {
                    print(resp.statusCode)
                }
                
            }
            // Continuing the URLSession task
            task.resume()
            // Handling the errors, if the request was unsuccessful
        } catch {
            print(Error.self)
        }
    }
}
