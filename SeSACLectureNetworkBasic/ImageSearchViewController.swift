//
//  ImageSearchViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()

    }
    
    // 네트워크 통신 시 메서드 이름: fetch or request or callRequest or get ... -> 서버의 response에 따라 네이밍을 설정해주기도 함.
    func fetchImage() {
        let text = "테니스".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1"
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
