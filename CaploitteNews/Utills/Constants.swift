//
//  Constants.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit

struct Constants {
    
    struct StoryBoard {
        static let Main = "Main"
        static let Reusables = "Reusables"
        static let Search = "Search"
        static let Profile = "Profile"
    }
    
    struct sourcesURL {
        static let PrivacyURL = "https://www.airbnb.com/"
        static let TermsURL = "https://www.wkndtrp.com/"
    }
    
    struct APIKeys {
        static let NewsAPIkey = "f26ee88000c546bc8effa4bbfbc739e3"
    }
    
    struct EncryptionKey {
        static let encryptionKey = "hjkdsfkjsdjfuyy2iu34" 
    }
     
    struct Colors {
        static let PrimaryColor = UIColor(named: "Primary Color") ?? .red
        static let SecondaryColor = UIColor(named: "Secondary Color") ?? .blue
        static let TertiaryColor = UIColor(named: "Tertiary Color") ?? .yellow
    }
    
    struct UserDefaultsName {
        static let userArray = "USERARRAY"
        static let regionCode = "REGIONCODE"
    }
    
    struct Strings {
        
        struct alertsHeader {
            static let alertTitel = "Alert"
            static let errorTitel = "Error"
        }
        
        struct alertsString {
            static let sameUserExist = "User name already exist"
            static let emailIssue = "E mail not correct"
            static let userNameIssue = "User name not correct"
            static let userNameOrPasswordNotCorrect = "User name or password not correct"
            static let reEnterPasswordError = "Password and re enter password mismatch"
            static let passwordError = "Passward must contain least one uppercase, least one digit, least one symbol, least one lowercase, min 6 characters total"
            static let limitedRequest = "You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours). Please upgrade to a paid plan if you need more requests"
        }
    }
}
