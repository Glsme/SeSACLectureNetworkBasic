//
//  ImageSearchViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var imageList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        
        imageSearchCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
        
        setCollectionViewUI()
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
                
                for item in json["items"].arrayValue {
                    let imageURL = item["link"].stringValue
                    self.imageList.append(imageURL)
                }
                
                print(self.imageList)
                
                self.imageSearchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionViewUI() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - ( spacing * 4)
        let height = UIScreen.main.bounds.height / 4
        layout.itemSize = CGSize(width: width / 3, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        imageSearchCollectionView.collectionViewLayout = layout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.searchImageView.kf.setImage(with: URL(string: imageList[indexPath.row]))
        
        return cell
    }
}
