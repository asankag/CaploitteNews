//
//  APIService.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation

class APIService: NSObject {
    
    
    func apiToGetTopHeadlineData(selectedCountry: String ,completion : @escaping (News) -> ()){
        let topHeadlineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(selectedCountry)&apiKey=\(Constants.APIKeys.NewsAPIkey)")!
        
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
    
    func apiToGetSearchData(keyword: String, sortBy: String, completion : @escaping (News) -> ()){
        let filteredURL = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&sortBy=\(sortBy)&apiKey=\(Constants.APIKeys.NewsAPIkey)")!
        
        URLSession.shared.dataTask(with: filteredURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let newsData = try! jsonDecoder.decode(News.self, from: data)
                completion(newsData)
            }
        }.resume()
    }
}
