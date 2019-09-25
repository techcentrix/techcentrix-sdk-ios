//
//  ViewController.swift
//  Example
//
//  Created by Kuba Reinhard on 10/06/2019.
//  Copyright © 2019 TechCentrix. All rights reserved.
//

import UIKit
import TechCentrixSDK

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let colors: TechCentrixSDK.Configuration.Colors = TechCentrixSDK.Configuration.Colors(primary: UIColor.red)
		let images: TechCentrixSDK.Configuration.Images = TechCentrixSDK.Configuration.Images()
		
		let configuration: TechCentrixSDK.Configuration = TechCentrixSDK.Configuration(apiToken: "API TOKEN", hostName: "Example", colors: colors, images: images)
		
		TechCentrixSDK.configure(with: configuration)
		
		UIApplication.shared.registerForRemoteNotifications()
		
		if !TechCentrixSDK.isSignedIn() {
			TechCentrixSDK.signIn(with: "ONETIMETOKEN") { (success: Bool) in
				if success {
					TechCentrixSDK.present(on: self)
				} else {
					print("Sign in failed")
				}
			}
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if TechCentrixSDK.isSignedIn() {
			TechCentrixSDK.present(on: self)
		}
	}
}
