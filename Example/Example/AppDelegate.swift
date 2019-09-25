//
//  AppDelegate.swift
//  Example
//
//  Created by Kuba Reinhard on 10/06/2019.
//  Copyright © 2019 TechCentrix. All rights reserved.
//

import FirebaseMessaging
import Firebase
import UIKit
import TechCentrixSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
		self.configureFirebase()
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Messaging.messaging().apnsToken = deviceToken
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		guard let info: [String: Any] = userInfo as? [String: Any] else {
			completionHandler(.failed)
			return
		}
		
		if TechCentrixSDK.isTechCentrixPush(userInfo: info) {
			TechCentrixSDK.handlePush(with: info) { _ in
				completionHandler(.newData)
			}
		}
	}
	
	private func configureFirebase() {
		FirebaseApp.configure()
		Messaging.messaging().delegate = self
	}
}

extension AppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		TechCentrixSDK.storeFirebaseRegistrationID(token: fcmToken)
	}
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        TechCentrixSDK.handleUserNotification(with: response, completion: completionHandler)
    }
}
