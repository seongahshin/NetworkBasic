//
//  TranslateViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

// UIButton, UITextField > Action
// UITextView, UISearchBar, UIPickerView > X
// UIControl > 상속받지 않아서
// UIResponderChain > userInputTextView.resignFirstResponder()
//userInputTextView.becomeFirstResponder()
class TranslateViewController: UIViewController {
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    @IBOutlet weak var userInputTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        userInputTextView.font = UIFont(name: "ROKAF-Slab-Serif-Medium", size: 17)
        requestTranslatedData()
    }
    
    func requestTranslatedData() {
        let url = EndPoint.translateURL
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        let parameter = ["source": "ko", "target": "en", "text": "안녕하세요 저는 고래밥 과자를 좋아합니다."]
        
        AF.request(url, method: .post, parameters: parameter ,headers: header).validate(statusCode: 200...500).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    print(json["message"]["result"]["translatedText"])
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    }
    





extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트의 글자가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 때 (커서가 깜박이기 시작할 때)
    // 텍스트뷰글자: 플레이스홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 텍스트에 대한 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
