//
//  SearchViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/// 1. 왼팔 / 오른팔
/// 2. 테이블 뷰 아울렛 연결
/// 3. 1 + 2

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 연결고리 작업: 테이블 뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchBar.delegate = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd" // TMI -> "yyyyMMdd" "YYYYMMdd" (찾아보세요)
//        let dateResult = Date(timeIntervalSinceNow: -86400)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateResult = format.string(from: yesterday!)
        
        requestBoxOffice(text: dateResult)
    }
    
    func requestBoxOffice(text: String) {
        
        //일별 박스오피스 배열 멤버 삭제
        self.list.removeAll()
        
        //인증키 제한
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let salesAcc = movie["salesAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, salesAcc: salesAcc)
                    
                    self.list.append(data)
                }
                
                print(self.list)
                
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else{ return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 16)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle) // \(list[indexPath.row].releaseDate)"
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        requestBoxOffice(text: text)
    }
}
