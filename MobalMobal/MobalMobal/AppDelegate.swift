//
//  AppDelegate.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/20.
//
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var shoudSupportAllOrientation: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setNavigationAppearance()
        
        FirebaseApp.configure()
        
        // setting Firebase Cloud Messaging
        setFCM()
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        setFCMToken()
        
        // setting Facebook Login
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // setting Google Login
        GIDSignIn.sharedInstance().clientID = "103202810083-nan5n1q6cmrtun6scg1uqt8g9n5ctng4.apps.googleusercontent.com"

        return true
    }
    
    // screen orientation
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if shoudSupportAllOrientation {
            return .all
        }
        return .portrait
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
    
    private func setNavigationAppearance() {
        let standard: UINavigationBarAppearance = UINavigationBarAppearance()
        
        // background
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .black94
        
        // title
        standard.titleTextAttributes = [
            .foregroundColor: UIColor.whiteTwo,
            .font: UIFont.spoqaHanSansNeo(ofSize: 17, weight: .medium)
        ]
        
        // button
        let btnAppearance: UIBarButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        btnAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        standard.buttonAppearance = btnAppearance
        
        UINavigationBar.appearance().standardAppearance = standard
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    private func setFCM() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    private func setFCMToken() {
        Messaging.messaging().token { token, error in
            if let error: Error = error {
                print("💥 Error fetching FCM registration token: \(error) 💥")
            } else if let token: String = token {
                print("🐰FCM registration token: \(token) 🐰")
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // 토큰 갱신 모니터링
        // print("🐰 Firebase registration token: \(fcmToken ?? "") 🐰")
        // let dataDict: [String: String] = ["token": fcmToken ?? ""]
        // NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}
