//
//  API Service.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 29/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import Alamofire

class ApiService {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://jiit-connect.firebaseapp.com/time_table"
    
    func fetchTimeTable(urlString: String, completionHandler: @escaping (Result<Schedule>) -> Void) {
        let url = "\(baseUrl)/\(urlString)"
//        print(url)
        Alamofire.request(url)
            .responseString { response in
//                print(response.result.value ?? "error")
                
                // check if responseJSON already has an error
                // e.g., no network connection
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(.failure(response.result.error!))
                    //                    completionHandler(false)
                    return
                }
                
                guard var jsonString = response.result.value else {
                    print("nil response")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Response is nil")))
                    //                    completionHandler(false)
                    return
                }
                
                let startIndex = (jsonString.range(of: "#A6")?.upperBound)!
                let endIndex = (jsonString.range(of: "@A6")?.lowerBound)!
                jsonString = jsonString[startIndex..<endIndex]
                
                self.parseResponse(jsonString: jsonString, completionHandler: completionHandler)
                
            }
    }
    
    func parseResponse(jsonString: String, completionHandler: @escaping (Result<Schedule>) -> Void){
        // make sure we got JSON and it's a dictionary
        guard let json = jsonString.convertToJSON() else {
            print("string is not JSON")
            completionHandler(.failure(BackendError.objectSerialization(reason: "Did not get JSON dictionary in response")))
            return
        }
        
        // create Todo from JSON, make sure it's not nil
        guard let schedule = Schedule(json: json) else {
            print("problem in JSON response")
            completionHandler(.failure(BackendError.objectSerialization(reason: "Could not create Schedule object from JSON")))
            return
        }

        let preferences = UserDefaults.standard
        preferences.set(jsonString, forKey: "timetable")
        preferences.synchronize()
        
        completionHandler(.success(schedule))
    }
}
