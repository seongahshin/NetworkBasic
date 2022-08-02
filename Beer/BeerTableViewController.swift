//
//  BeerTableViewController.swift
//  NetworkBasic
//
//  Created by 신승아 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerTableViewController: UITableViewController {
    
    var list: [BeerModel] = []
    
    
    @IBOutlet weak var TItle: UILabel!
    @IBOutlet var beerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestBeer()
//        beerTableView.rowHeight = UITableView.automaticDimension
       titleDesign()
        
    }
    
    func titleDesign() {
        TItle.text = "Beer Dictionary"
        TItle.textAlignment = .center
        TItle.font = .boldSystemFont(ofSize: 20)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as! BeerTableViewCell
        let url = URL(string: list[indexPath.row].imageBeer)
        cell.beerName.text = "\(list[indexPath.row].nameBeer)"
        cell.beerDescription.text = "\(list[indexPath.row].describeBeer)"
        cell.beerImage.kf.setImage(with: url)
        
        cell.beerName.font = .boldSystemFont(ofSize: 11)
        cell.beerName.textAlignment = .center
        
        cell.beerDescription.font = .systemFont(ofSize: 10)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func requestBeer() {
        
            let url = "https://api.punkapi.com/v2/beers"
            AF.request(url, method: .get).validate().responseJSON { [self] response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    
                    print(json.count)
                    
                    for k in 0...json.count-1 {
                        let BN = json[k]["name"].stringValue
                        let BD = json[k]["description"].stringValue
                        let BI = json[k]["image_url"].stringValue
                        
                        let data = BeerModel(imageBeer: BI, nameBeer: BN, describeBeer: BD)
                        self.list.append(data)
                    }
    
                        
                        
                    print(self.list)
                    self.beerTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                        
                    }
                    
                }
            }
        }
    
   


