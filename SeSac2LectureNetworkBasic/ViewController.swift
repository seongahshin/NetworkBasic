//
//  ViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController {
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return .blue
        }
    }
    static var identifier: String = "ViewController"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    

}

