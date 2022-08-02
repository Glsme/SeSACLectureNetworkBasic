//
//  BeerListCollectionViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/02.
//

import UIKit

private let reuseIdentifier = "Cell"

class BeerListCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCollectionViewCell.identifier, for: indexPath) as? BeerListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = 10
        
        return cell
    }

}
