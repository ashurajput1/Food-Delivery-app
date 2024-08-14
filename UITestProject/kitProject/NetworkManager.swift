//
//  NetworkManager.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 30/07/24.
//

import Foundation
import SwiftUI


class NetworkManager{
    let cache = NSCache<NSString, NSData>()
    static let shared = NetworkManager()
    private init(){}
    func fetchData<T:Decodable>(from urlString: String,completionHandler:@escaping(Result<T,Error>) -> Void)  {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlString)! )) { Data, urlResponse, Error in

                  if let data = Data {
                      print("Data: \(data)")
                      // If you want to print data as a string
                      if let dataString = String(data: data, encoding: .utf8) {
                          print("Data as String: \(dataString)")
                          do
                          {
                              let menuResponse = try JSONDecoder().decode(T.self, from: data)
                              completionHandler(.success(menuResponse))
                              
                          }
                          catch {
                              completionHandler(.failure(Error!))
                          }
                          
                         

                      }
                  } else {
                      print("No data received")
                  }
        }
        .resume()
    }
    func downloadData(urlString:String,completionHandler:@escaping (Result<Data,Error>) -> Void) {
        if let data = object(forKey: urlString) {
            print("present already")
            completionHandler(.success(data))
        } else {
            print("new download")
            URLSession.shared.dataTask(with: URL(string: urlString)!) { data , response , error in
                if error == nil {
                    self.setObject(data!, forKey: urlString)
                    completionHandler(.success(data!))
                } else {
                    completionHandler(.failure(error!))
                }
            }
            .resume()
        }

    }
    func setObject(_ data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString )
    }
    
    func object(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
}

struct MenuResponse: Decodable {
    let request: [MenuItem]
}
