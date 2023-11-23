//
//  DashboardViewModel.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation

class DashboardViewModel: NSObject {
    private var apiService: APIService!
    
    private(set) var newsData : News! {
        didSet {
            self.bindNewsViewModelToController()
        }
    }
    
    var bindNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getHeadlineData()
    }
    
    func getHeadlineData() {
        self.apiService.apiToGetTopHeadlineData { (newsData) in
            self.newsData = newsData
        }
    }
}
