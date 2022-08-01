//
//  ViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/28.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {
    static var identifier: String = "ViewController"
    
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor = .blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        
        title = UserDefaultsHelper.standard.nickname
        UserDefaultsHelper.standard.age = 80
        
        print(UserDefaultsHelper.standard.age)
    }
    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
        backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    func congigureLabel() {
        
    }
}
