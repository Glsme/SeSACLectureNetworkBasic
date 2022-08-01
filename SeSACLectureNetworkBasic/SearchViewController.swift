//
//  SearchViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/27.
//

import UIKit

/// 1. 왼팔 / 오른팔
/// 2. 테이블 뷰 아울렛 연결
/// 3. 1 + 2

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 연결고리 작업: 테이블 뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else{ return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        
        return cell
    }
    
}
