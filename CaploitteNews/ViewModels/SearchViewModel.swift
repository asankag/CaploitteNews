//
//  SearchViewModel.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/23/23.
//

import Foundation

class SearchViewModel: NSObject {
    private var apiService: APIService!
    
    private(set) var newsData : News! {
        didSet {
            self.bindSearchedNewsViewModelToController()
        }
    }
    
    var bindSearchedNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getSearchData(keyword: "Bitcoin", sortBy: "Latest")
    }
    
    func getSearchData(keyword: String, sortBy: String) {
        self.apiService.apiToGetSearchData(keyword: keyword, sortBy: sortBy) { (newsData) in
            self.newsData = newsData
        }
    }
}
