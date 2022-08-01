//
//  TranslateViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by 신승아 on 2022/07/28.
//

import UIKit

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
