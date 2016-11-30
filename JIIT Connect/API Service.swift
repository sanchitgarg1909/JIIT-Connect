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
    
    let baseUrl = "https://tart-scarf-9196.nanoscaleapi.io"
    
//    func fetchVideos(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
//    }
//    
//    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
//    }
//    
//    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
//    }
    
    func fetchTimeTable(urlString: String, completionHandler: @escaping (Result<Schedule>) -> Void) {
        let url = "\(baseUrl)/\(urlString)"
        print(url)
        Alamofire.request(url)
            .responseString { response in
//                print(response.result.value ?? "error")
            }
            .responseJSON { response in
                
                // check if responseJSON already has an error
                // e.g., no network connection
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(.failure(response.result.error!))
//                    completionHandler(false)
                    return
                }
                
                // make sure we got JSON and it's a dictionary
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get todo object as JSON from API")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Did not get JSON dictionary in response")))
//                    completionHandler(false)
                    return
                }
                
                // create Todo from JSON, make sure it's not nil
                guard let schedule = Schedule(json: json) else {
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Could not create Todo object from JSON")))
//                    completionHandler(false)
                    return
                }
                completionHandler(.success(schedule))
//                completionHandler(true)
        }
    }
}

enum BackendError: Error {
    case objectSerialization(reason: String)
}
