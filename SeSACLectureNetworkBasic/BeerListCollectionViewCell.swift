//
//  BeerListCollectionViewCell.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/02.
//

import UIKit

class BeerListCollectionViewCell: UICollectionViewCell {
    static let identifier = "BeerListCollectionViewCell"
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerExplain: UILabel!
}
