//
//  BeerListCollectionViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class BeerListCollectionViewController: UICollectionViewController {
    
    var beerList: [Beer] = []
    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        requestBeerList()
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 2)
        let height = UIScreen.main.bounds.height / 3.5
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        print("Layout Done")
    }
    
    func requestBeerList() {
        let url = EndPoint.beerListURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for num in 1...25 {
                let name = json[num]["name"].stringValue
                let image_url = json[num]["image_url"].stringValue
                let description = json[num]["description"].stringValue
                
                let data = Beer(name: name, image_url: image_url, description: description)
                
                self.beerList.append(data)
                }
                
                self.beerCollectionView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beerList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCollectionViewCell.identifier, for: indexPath) as? BeerListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.beerImageView.kf.setImage(with: URL(string: beerList[indexPath.row].image_url))
        cell.beerName.text = beerList[indexPath.row].name
        cell.beerExplain.text = beerList[indexPath.row].description
        
        return cell
    }

}
