//
//  LottoViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON


class LottoViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
   
    @IBOutlet weak var bonusLabel: UILabel!
    
    
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있습니다.
    
    let lottoList: [Int] = Array(1...1025).reversed()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        requestLotto(number: lottoList[0])
    }
    
    func requestLotto(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                
                
                let numberList: [Int] = [1,2,3,4,5,6,7]
                let labelSet: [UILabel?] = [firstLabel, secondLabel, thirdLabel, fourthLabel, fifthLabel, sixthLabel, bonusLabel]
                
                for num in numberList {
                    let pickednumber = json["drwtNo\(num)"].intValue
                    labelSet[num-1]?.text = "\(pickednumber)"
                    
                    if num == 7 {
                        let pickednumber = json["bnusNo"].intValue
                        labelSet[num-1]?.text = "\(pickednumber)"
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: lottoList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(lottoList[row])회차"
    }
}
