//
//  ForgotPassword.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct ForgotPass {
    let baseURL : URL
    
    init(endp : String) {
        let URLstring = "https://mycampus-server.karage.fi\(endp)"
        guard let baseURL = URL(string: URLstring) else {fatalError()}
        
        self.baseURL = baseURL
    }
    
    func forgotP(_ model:forgotPassModel, completion: @escaping(Result<ResetResp, Error>) -> Void) {
        do {
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(model)
           // print(request.description)
            
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let data = data {// check for http errors
                    do {
                        if let text = String(bytes: data, encoding: .utf8){
                            print(text)
                            }
                        let body = try JSONDecoder().decode(ResetResp.self, from: data)
                        print(body)
                    } catch {
                        print("There was an error parsing data:", error)
                    }
                }
                if let resp = response as? HTTPURLResponse {
                    print(resp.self)
                }

            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
    }
}
