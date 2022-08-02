//
//  SearchViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol - 왼팔, 오른팔이 여기에 속함
 - Delegate
 - DataSource
 
 1. 왼팔/ 오른팔 가지고 와야 함
 2. 테이블뷰 아웃렛 연결
 3. 1 + 2
 */

// 부모클래스가 테이블뷰가 아니라서 override 아님
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // BoxOffice 담을 배열
    var list: [BoxOfficeModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {return UITableViewCell()}
        cell.titldLabel.font = .boldSystemFont(ofSize: 22)
        cell.titldLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseData)"
        return cell
    }

    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 연결고리 작업: 테이블뷰가 해야할 역할을 뷰컨트롤러에게 요청하는 역할
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // xib: xml interface buildr <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        requestBoxOffice(text: "20220801")
        searchBar.delegate = self
        
       
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    func requestBoxOffice(text: String) {
        
        list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNM = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNM, releaseData: openDt, totalCount: audiAcc)
                    self.list.append(data)
                }

        
                print(self.list)
                self.searchTableView.reloadData()
    
            case .failure(let error):
                print(error)
            }
        }
    }
    
    }

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!)
    }
}
    


