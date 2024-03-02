//
//  Urls.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import Foundation
class Urls {
    static let BASE_URL = "http://api.ozinshe.com/core/V1/"
    
    static let SIGN_IN_URL = "http://api.ozinshe.com/auth/V1/signin"
    static let SIGN_UP_URL = "http://api.ozinshe.com/auth/V1/signup"
    static let PERSONAL_DATA_URL = BASE_URL + "user/profile/"
    static let CHANGE_PASS_URL = BASE_URL + "user/profile/changePassword"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let MAIN_BANNERS_URL = BASE_URL + "movies_main"
    static let USER_HISTORY_URL = BASE_URL + "history/userHistory"
    static let MAIN_MOVIES_URL = BASE_URL + "movies/main"
    static let GET_GENRES_URL  = BASE_URL + "genres"
    static let GET_AGES_URL = BASE_URL + "category-ages"
    static let FAVORITES_URL = BASE_URL + "favorite/"
    static let ADD_FAVORITES_URL = BASE_URL + "favorite/"
    static let GET_SEASONS = BASE_URL + "seasons/"
    static let GET_SIMILAR = BASE_URL + "movies/similar/"
    static let GET_PROFILE_URL = BASE_URL + "user/profile"
    static let UPDATE_PROFILE_URL = BASE_URL + "user/profile/"
}
