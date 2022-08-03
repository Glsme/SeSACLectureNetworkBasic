//
//  ReusableViewProtocol.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol { //extension 저장 프로퍼티 불가능
    
    static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
    
}


extension UITableViewCell: ReusableViewProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
