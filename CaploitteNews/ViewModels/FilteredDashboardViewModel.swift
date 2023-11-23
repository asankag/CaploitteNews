//
//  FilteredDashboardViewModel.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/23/23.
//

import Foundation

class FilteredDashboardViewModel: NSObject {
    private var apiService: APIService!
    
    private(set) var newsData : News! {
        didSet {
            self.bindFiltedNewsViewModelToController()
        }
    }
    
    var bindFiltedNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getHeadlineData(keyword: "General")
    }
    
    func getHeadlineData(keyword: String) {
        self.apiService.apiToGetFiltedData(keyword: keyword) { (newsData) in
            self.newsData = newsData
        }
    }
}
