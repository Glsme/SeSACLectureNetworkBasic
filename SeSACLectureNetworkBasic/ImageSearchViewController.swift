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

    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var imageList: [String] = []
    
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        imageSearchCollectionView.prefetchDataSource = self // 페이지네이션
        imageSearchBar.delegate = self
        
        imageSearchCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
        
        setCollectionViewUI()
    }
    
    // 네트워크 통신 시 메서드 이름: fetch or request or callRequest or get ... -> 서버의 response에 따라 네이밍을 설정해주기도 함.
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.imageList.append(contentsOf: list)
            self.imageSearchCollectionView.reloadData()
        }
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼 클릭 시 실행.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageList.removeAll()
            startPage = 1
            
//            imageSearchCollectionView.scrollsToTop
            
            fetchImage(query: text)
        }
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageList.removeAll()
        imageSearchCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}

// 페이지네이션 방법3.
// 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수 도 있고, 필요하지 않다면 데이터를 취소할 수 도 있음.
// iOS10 이상, 스크롤 성능 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if imageList.count - 1 == indexPath.item && imageList.count < totalCount {
                startPage += 30
                fetchImage(query: imageSearchBar.text!)
            }
        }
        
//        print("=========\(indexPaths)==========")
    }
    
    // 취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("OOOOOOOOO\(indexPaths)OOOOOOOOOO")
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
    
    // 페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드.
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기 어려움.
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    
    
    // 페이지네이션 방법2. UICscrollViewDelegateProtocol.
    // 테이블뷰와 컬렉션뷰는 스크롤뷰를 상속받고있어서 스크롤뷰 프로토콜 사용 가능.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
}
