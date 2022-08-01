//
//  Constant.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/01.
//

import Foundation

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
