//
//  APIService.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation

class APIService: NSObject {
    private let topHeadlineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(Constants.APIKeys.NewsAPIkey)")!
    
    func apiToGetTopHeadlineData(completion : @escaping (News) -> ()){
        URLSession.shared.dataTask(with: topHeadlineURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let newsData = try! jsonDecoder.decode(News.self, from: data)
                completion(newsData)
            }
        }.resume()
    }
    
    func apiToGetFiltedData(keyword: String, completion : @escaping (News) -> ()){
        let filteredURL = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=\(Constants.APIKeys.NewsAPIkey)")!
        
        URLSession.shared.dataTask(with: filteredURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let newsData = try! jsonDecoder.decode(News.self, from: data)
                completion(newsData)
            }
        }.resume()
    }
}
