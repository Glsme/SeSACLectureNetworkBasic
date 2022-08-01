//
//  LocationViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    // Notification 1.
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Font
        for family in UIFont.familyNames {
            
            if family.contains("Happiness") {
                print("=====\(family)=======")
                
                for name in UIFont.fontNames(forFamilyName: family) {
                    print(name)
                }
            }
            
         }

        requestAuthorization()
    }

    @IBAction func noticationButtonClicked(_ sender: UIButton) {
//        requestAuthorization()
    }
    // Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authorizations = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizations) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    // Notification 3. 권한 허용한 사용자에게 알림 요청 (언제 보낼지, 어떤 컨텐츠로 보낼지)
    // iOS 시스템에서 알림을 담당 -> 알림 등록
    
    /*
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서 60초 이상 반복 가능 / 갯수 제한 64개 / 커스텀 사운드 30초
     
     1. 뱃지 제거? -> 언제 제거하는게 맞을까?
     2. 노티 제거? -> 노티의 유효 기간은?
     3. 포그라운드 수신? -> 딜리게이트 메서드로 해결
     
     +a
     - 쿠팡
     */

    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "배고파요"
        notificationContent.badge = 40
        
        // 언제 보낼지, 1. 시간 간격, 2. 캘린더, 3.위치에 따라 설정 가능.
        // 시간 간격일 땐 60초 이상 설정해야 반복 가능
        
        var dateComponent = DateComponents()
        dateComponent.minute = 15
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 알림 요청
        // identifier:
        // 만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜주는 정도.
        // 만약 알림 관리 할 필요 O -> +1, 고유 이름, 규칙 등
        let request = UNNotificationRequest(identifier: "hi", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
}
