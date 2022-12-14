//
//  LottoViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    @IBOutlet var lottoNumLabels: [UILabel]!
    
    var drwNoDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.textContentType = .oneTimeCode // 인증번호
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: numberOfDayBetween()/7 + 1)
        
    }
    
    func numberOfDayBetween() -> Int {
        let now = Date()
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.day = 7
        components.month = 12
        components.year = 2002
        
        let specialDay = calendar.date(from: components)
        
        components = calendar.dateComponents([.day], from: specialDay!, to: now)
        
        return Int(components.day ?? 0)
    }
    
    func requestLotto(number: Int) {
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        
        //AF: 200~299 status code
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.drwNoDate = json["drwNoDate"].stringValue
                
                let bonus = json["bnusNo"].intValue
                let date = json["drwNoDate"].stringValue
                var lottoNumArray: [String] = []
                
                for num in 1...6 {
                    lottoNumArray.append(json["drwtNo\(num)"].stringValue)
                }
                
                lottoNumArray.append("\(bonus)")
                
                for num in 0...6 {
                    self.lottoNumLabels[num].text = lottoNumArray[num]
                }
                
//                print(lottoNumArray)
                
                self.numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
//        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }

}
