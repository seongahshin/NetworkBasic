//
//  Constant.swift
//  NetworkBasic
//
//  Created by 신승아 on 2022/08/01.
//

import Foundation

//enum StoryboardName {
//    case Main
//    case Search
//    case Setting
//}

struct StoryboardName {
    // 접근 제어를 통해 초기화 방지
    private init() {
        
    }
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

/*
 1. struct type property vs enum type property => 인스턴스에 대한 생성을 방지할 수 있다.
 2. enum case vs enum static => 중복, case 제약 
 */

//enum StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum FontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
