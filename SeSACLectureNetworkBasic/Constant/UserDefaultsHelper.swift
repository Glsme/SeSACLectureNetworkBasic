//
//  UserDefaultsHelper.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    private init() { }
    
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음.
    static let standard = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, lottoCount
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        
        set { // 연산 프로퍼티 parameter : newValue
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    var lottoCount: Int {
        get {
            return userDefaults.integer(forKey: Key.lottoCount.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.lottoCount.rawValue)
        }
    }
}
