//
//  NetworkOperation.swift
//  WeatherEye
//
//  Created by Cotten Blackwell on 11/7/15.
//  Copyright © 2015 Cotten Blackwell. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]? -> Void)
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check HTTP response for successful GET request
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // 2. Create JSON object with data
                    let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: [])) as? [String: AnyObject]
                    completion(jsonDictionary)
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
    }
}