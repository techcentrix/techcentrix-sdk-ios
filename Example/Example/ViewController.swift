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
		let colors: TechCentrixSDK.Configuration.Colors = TechCentrixSDK.Configuration.Colors(primary: UIColor.red, secondary: UIColor.purple)
		let images: TechCentrixSDK.Configuration.Images = TechCentrixSDK.Configuration.Images()
		
		let configuration: TechCentrixSDK.Configuration = TechCentrixSDK.Configuration(apiToken: "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJST0xFX01PQklMRSIsInN1YiI6IlJPTEVfTU9CSUxFIiwiYXV0aCI6WyJST0xFX01PQklMRSJdLCJ0eXBlIjoiYWNjZXNzIiwiY3VzdG9tZXIiOiJkZW1vIiwiZXhwIjoxNjQ4OTk1NTM5fQ.MD3jcfZuZ_d5uSzfCqO_CWz3FhUaZ9nZSUuiOIaoomdCXyNEc-WdIfD8kcbhQpJKTbCHACSW2fs4DM8QidxLIg", hostName: "Example", colors: colors, images: images)
		
		TechCentrixSDK.configure(with: configuration)
		
		if !TechCentrixSDK.isSignedIn() {
			TechCentrixSDK.signIn(with: "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5YjNlNDgyMi05YjI1LTQyNmUtYjdmZi1mNjg1YzFlODY4M2IiLCJzdWIiOiJCYXJ0MSIsImF1dGgiOlsiUk9MRV9VU0VSIl0sInR5cGUiOiJhY2Nlc3MiLCJleHAiOjE1NjAxODE2ODh9.cyA1aVes5EJRDrHrg-XjQADkpaB1VcA4LMCgz9DnFVHfzX3tyHQ8D366Y5BRlX10OsIpbN7mmfSjDdx-USYrWg") { (success: Bool) in
				if success {
					TechCentrixSDK.present(on: self)
				} else {
					print("Sign in failed")
				}
			}
		} else {
			TechCentrixSDK.present(on: self)
		}
	}
}
