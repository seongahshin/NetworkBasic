//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by 신승아 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    
    
    /*
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 60초 이상 반복 가능 (로컬 알림) / 갯수는 64개까지 받을 수 있음
     
     + alp
     - 노티는 앱 실행이 기본인데 특정 노티에 따라서 특정화면으로 가고 싶다면?
     - 포그라운드 수신 > 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
     - iOS 15
     
     */
    
    // Notification 1.
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        requestAuthorization()

        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        sendNotification()
    }
    // Notification 2. 권한요청
    func requestAuthorization() {
        let authorizationOption = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOption) { success, error in
            // 함수 안에 함수가 있는 형태라 self 붙음
            if success {
                self.sendNotification()
            }
        }
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청(언제? 어떻게?)
    // iOS 시스템에서 알림을 담당 > 알림 등록
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))"
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가?(시간 간격, 캘린더, 위치)
        // 시간간격일 때는 60초 이상으로 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        var dateComponents = DateComponents()
        dateComponents.minute = 15
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // 알림 요청
        // identifier: 만약 알림 관리할 필요 x -> 알림 클릭하면 앱을 켜주는 정도
        // 만약 알림 관리 필요 O -> + 1, 고유 이름, 규칙
        let request = UNNotificationRequest(identifier: "jack", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
        
    }
    


}
