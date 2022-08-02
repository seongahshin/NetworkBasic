//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 신승아 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Design()
        requestRandomBeer()
    }
    
    func Design() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "ROKAF-Slab-Serif-Medium", size: 16)
        
        beerDescription.font = UIFont(name: "ROKAF-Slab-Serif-Medium", size: 11)
        beerDescription.textAlignment = .natural
        beerButton.backgroundColor = UIColor.lightGray
        beerButton.setTitleColor(UIColor.white, for: .normal)
        beerButton.setTitle("Just Click & Drink", for: .normal)
        beerButton.layer.cornerRadius = 20
        
        
    }
    func requestRandomBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let beername = json[0]["name"].stringValue
                self.titleLabel.text = beername
                
                let beerURL = json[0]["image_url"].stringValue
                let url = URL(string: beerURL)
                self.beerImage.kf.setImage(with: url)
                
                let beerDescribe = json[0]["description"].stringValue
                self.beerDescription.text = beerDescribe
                
            case .failure(let error):
                print(error)
            }
        }
      
      
      
    }
    
    @IBAction func beerButtonClicked(_ sender: Any) {
        requestRandomBeer()
    }
    

}
