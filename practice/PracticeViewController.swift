//
//  PracticeViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/27.
//

import UIKit

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var practiceTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        practiceTableView.delegate = self
        practiceTableView.dataSource = self
        
        practiceTableView.register(UINib(nibName: "PracticeTableViewCell", bundle: nil), forCellReuseIdentifier: "PracticeTableViewCell")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeTableViewCell", for: indexPath) as? PracticeTableViewCell else {return UITableViewCell()}
        
        cell.blackButton.setTitle("눌러", for: .normal)
        cell.blackButton.setTitleColor(.white, for: .normal)
        return cell
    }

    

}
