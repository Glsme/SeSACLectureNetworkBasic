//
//  TranslateViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해주세요."

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "Happiness-Sans-Bold", size: 16)
        outputTextView.font = UIFont(name: "Happiness-Sans-Bold", size: 16)
        
//        requestTranslatedData()
        
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        guard let text = userInputTextView.text else { return }
        requestTranslatedData(text: text)
    }
    
    func requestTranslatedData(text: String) {
        let url = EndPoint.translateURL
        let parameter = ["source": "ko", "target": "en", "text": text]
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                } else {
                    self.outputTextView.text = json["errorMessage"].stringValue
                }
                
                self.outputTextView.text = json["message"]["result"]["translatedText"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 때, 커서가 시작될 때
    // 텍스트 뷰 글자: textViewPlaceholderText와 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트 뷰 글자: 사용자가 아무 글자도 쓰지 않았으면 textViewPlaceholderText 띄우기
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
