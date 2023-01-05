//
//  Constants.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 18.12.2022.
//

import Foundation

enum Constants {
    static let showSingleImageSegueIdentifier = "ShowSingleImage"
    static let showWebViewSegueIdentifier = "ShowWebView"
    static let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    static let unsplashAuthoriseTokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let accessKey = "yyiGw4oPVfUiT0R8s6s3GKltoa_KT_bkn8NLSxQNkoA"
    static let secretKey = "p3UcTsOk49XXjvG3E2Rb5QqjrU59Sb7PQUH2-kerGqo"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public + read_user + write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com/")
    
    enum NetworkError: Error {
        case codeError
    }
}
