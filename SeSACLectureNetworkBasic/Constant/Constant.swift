//
//  Constant.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "d72477c2e5d160421aa08821e8f14980"
    static let NAVER_ID = "lkd5WsJ6WIQxG2JdYM8c"
    static let NAVER_SECRET = "sNpDgT9XCw"
    static let TMDB = "d28b1cdae6a29435ccdade828e04d302"
    static let OPENWEATHER = "55e7fde5e9c8c2695229afd6b4c288f1"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let beerListURL = "https://api.punkapi.com/v2/beers"
    static let imageSearchURL = "https://openapi.naver.com/v1/search/image.json?"
}


//enum StoryboardName {
//    case Main
//    case Search
//    case Setting
//}

struct StoryboardName {
    
    private init() {
        
    }
    
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

/*
 1. struct type property vs enum type property -> 인스턴스 생성 방지
 */

//enum StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum FontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
