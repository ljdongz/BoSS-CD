//
//  AppDelegate.swift
//  iOS
//
//  Created by 이정동 on 2023/01/09.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseCore
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Google API Key 설정
        GMSServices.provideAPIKey(Bundle.main.GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(Bundle.main.GOOGLE_API_KEY)
        
        // Firebase 연결을 위한 초기화 설정
        FirebaseApp.configure()
        
        
//        //폰트 적용
//        // 앱 전체의 글꼴 스타일 정의
//        let fontName = "SUITE-Bold" // 변경하고자 하는 폰트 이름으로 설정합니다.
//        let font = UIFont(name: fontName, size: 16)!
//
//        // UILabel의 글꼴 스타일 설정
//        UILabel.appearance().font = UIFontMetrics.default.scaledFont(for: font)
//
//        // UIButton의 글꼴 스타일 설정
//        UIButton.appearance().titleLabel?.font = UIFontMetrics.default.scaledFont(for: font)
//
//        // UITextField의 글꼴 스타일 설정
//        UITextField.appearance().font = UIFontMetrics.default.scaledFont(for: font)
//
//        // UITextView의 글꼴 스타일 설정
//        UITextView.appearance().font = UIFontMetrics.default.scaledFont(for: font)
//        
       
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
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

