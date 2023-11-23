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
        let regionCode = UserDefaults.standard.string(forKey: Constants.UserDefaultsName.regionCode) ?? "us"
        getHeadlineData(selectedCountry: regionCode)
    }
    
    func getHeadlineData(selectedCountry: String) {
        self.apiService.apiToGetTopHeadlineData(selectedCountry: selectedCountry) { (newsData) in
            self.newsData = newsData
        }
    }
}
