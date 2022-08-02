//
//  BeerViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {

    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recommendBeer()
    }
    
    func recommendBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let beerInfo = json[0]
                let beerName = beerInfo["name"].stringValue
                let description = beerInfo["description"].stringValue
                let imageUrl = beerInfo["image_url"].stringValue
                
                self.beerNameLabel.text = beerName
                self.descriptionLabel.text = description
                self.beerImageView.kf.setImage(with: URL(string: imageUrl))
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

