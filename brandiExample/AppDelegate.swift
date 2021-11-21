//
//  AppDelegate.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



// 1. 과제 내용:
// 카카오 'Daum 검색 - 이미지 검색' api를 사용하여 이미지 검색 앱을 만듭니다.
//
// 2. 다음과 같이 진행해주세요.
//
// 1) 카카오 Developer 계정은 개인 계정으로 만듭니다.


/// ``SearchViewController`
// 2) UISearchBar에 문자를 입력 후 1초가 지나면 자동으로 검색이 됩니다.
//
// 3) 검색어가 변경되면 목록 리셋 후 다시 데이터를 fetch 합니다.
//      데이터는 30개씩 페이징 처리합니다. (최초 30개 데이터 fetch 후 스크롤 시 30개씩 추가 fetch)
//
// 4) 검색 결과 목록은 UICollectionView를 사용하여 3xN 그리드 모양으로 구성합니다.
//      (각 아이템은 동일한 크기로 정사각형 형태)
//      검색 결과가 없을 경우 '검색 결과가 없습니다.' 메시지를 화면에 보여줍니다.
//      검색 결과 목록 중 하나를 탭 하였을 때 전체 화면으로 이미지를 보여줍니다.
//
//
/// ``DescViewController``
// 5) 전체 이미지 표시 할때 좌우 여백이 0이고, 이미지 비율은 유지하도록 보여줍니다.
//      이미지가 세로로 길 경우 스크롤 됩니다.
//      response 데이터에 출처 'display_sitename', 문서 작성 시간 'datetime'이 있을 경우 전체화면 이미지 밑에 표시해 줍니다.
//      이 외 UI는 자유롭게 구성합니다.
//
// 6) 오픈소스 라이브러리는 자유롭게 사용 가능합니다.
//
//
//  ※ 결과물은 개인 github에 올려주시고, labs-ma-ios@brandi.co.kr 으로 URL 공유 부탁드립니다.
//
//
// 3. 아래 기술을 구현 시, 우대합니다.
// - RxSwift || Combine 사용
// - Test 코드 구현
// - Error 핸들링
// - SwiftUI 사용
//
//
// 4. 과제 결과물에 대해 아래 기준으로 검토하오니, 참고해주세요!
// - 필수 구현사항 동작 여부
// - UI 완성도
// - 사용한 Architecture 이해도
// - 기능이나 역할에 따른 폴더 구조
// - 코드 가독성
// - 페이징 처리 완성도
