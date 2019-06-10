TechCentrix SDK is a Swift framework for connecting mobile app and TechCentrix Bluetooth devices, like clips or wristbands.

- [TechCentrix SDK](#techcentrix-sdk)
  * [Step 1 - Integrate your backend with TechCentrix backend](#step-1---integrate-your-backend-with-techcentrix-backend)
  * [Step 2 - Integrate your mobile application with TechCentrix SDK](#step-2---integrate-your-mobile-application-with-techcentrix-sdk)
  * [Step 3 - Configure TechCentrix module](#step-3---configure-techcentrix-module)
  * [Step 4 - Start TechCentrix module](#step-4---start-techcentrix-module)
  * [Step 5 - Passing TechCentrix's push notifications](#step-5---passing-techcentrix-s-push-notifications)
- [API Documentation](#api-documentation)
- [Credits](#credits)
- [Licence](#licence)

## TechCentrix SDK

[Read more about our LED technology.](http://techcentrix.github.io/)

### Step 1 - Integrate your backend with TechCentrix backend

[Read more about Step 1](http://techcentrix.github.io/quick-start-guide#backend-integration)

### Step 2 - Integrate your mobile application with TechCentrix SDK

#### Requirements

* Swift 5.0+
* iOS 11.0+

#### Installation with CocoaPods
CocoaPods is a dependency manager for Swift/Objective-C, which automates and simplifies the process of using 3rd-party libraries like TechCentrix SDK in your projects. See the "Getting Started" guide for more information. You can install it with the following command:

`$ gem install cocoapods`
> CocoaPods 1.6.1+ is required to build TechCentrix SDK.

#### Access to CocoaPods

To access the CocoaPods repository, contact [TechCentrix](https://techcentrix.com).

#### Podfile

To integrate TechCentrix into your Xcode project using CocoaPods, specify it in your Podfile:

```
platform :ios, '11.0'

target 'YourTargetName' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YourTargetName
  pod 'TechCentrixSDK', :git => 'git@bitbucket.org:techcentrix/techcentrix-sdk-ios.git'
  #You also need to use Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
end
```

As our SDK uses Firebase to receive push notifications, don't forget to add Firebase pods to your Podfile.

```
pod 'Firebase/Core'
pod 'Firebase/Messaging'
```

Then, run the following command:

`$ pod install`

#### Firebase

If you have Firebase configured in your project, please skip Step 1.
1. Configure Firebase in your project as described [here](https://firebase.google.com/docs/ios/setup).
2. Configure your iOS app in Firebase console - Settings/Cloud Messaging/iOS app configuration. Add *APNs Authentication Key* [Apple Source](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)
3. If you have *Firebase Server Key* for Android app, please add it to our [TechCentrix Config file](https://sdk.techcentrix.com/quick-start-guide#dictionary), otherwise generate new. Use it for Android project as well.

### Step 3 - Configure TechCentrix module

You can configure TechCentrix module by passing [Swift struct](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) to our SDK.

Item | Description
--- | ---
MobileAPIKey | API token for a mobile app
hostName | Host app name
productName | Name of a product - "Wristband" - e.g. "Zoe's Wristband", "Add New Wristband"
Colors | Color configuration struct for colors used within the SDK. [More here.](#colors)
Images| Image configuration struct for images used within the SDK. [More here.](#images)

#### Colors
Item | Description
--- | ---
Colors.primary | Primary color, that is used across the app
Colors.secondary | Secondary color, that is used across the app

#### Images

Item | Description | Image  | Screenshot
--- | --- | --- | ---
productImage | Name of an image, that is used on a list of clips |  <img src="website/assets/productImage.png?raw=true" width="200"> | <img src="website/ProductImage.png?raw=true" width="200">
productImageAddNew | Name of an image, that is used on a list of clips | <img src="website/assets/productImageAddNew.png?raw=true" width="200"> | <img src="website/ProductImageAddNew.png?raw=true" width="200">
productImageLED | Name of an image, that is presents LED display. | <img src="website/assets/productImageLED.png?raw=true" width="200"> | <img src="website/ProductImageLED.png?raw=true" width="200">
productImagePairing | Name of an image, that is used on a pairing screen | <img src="website/assets/productImagePairing.png?raw=true" width="200"> | <img src="website/ProductImagePairing.png?raw=true" width="200">
productImagePairingOnOff | Name of an image, that is used on a pairing screen with zoomed On/Off button | <img src="website/assets/productImagePairingOnOff.png?raw=true" width="200"> | <img src="website/ProductImagePairingOnOff.png?raw=true" width="200">

Example:

```
let colors: TechCentrixSDK.Configuration.Colors = TechCentrixSDK.Configuration.Colors(primary: UIColor.yourPrimaryColor, secondary: UIColor.yourSecondaryColor)
let images: TechCentrixSDK.Configuration.Images = TechCentrixSDK.Configuration.Images(product: UIImage(named: "productImage"),
												productAdd: UIImage(named: "productImageAddNew"),
												productLED: UIImage(named: "productImageLED"),
												pairing1: UIImage(named: "productImagePairing"),
												pairing2: UIImage(named: "productImagePairingOnOff"))
let configuration: TechCentrixSDK.Configuration = TechCentrixSDK.Configuration(apiToken: "Mobile.API.Token", hostName: "The Bekan", productName: "Display", colors: colors, images: images)
TechCentrixSDK.configure(with: configuration)

```

### Step 4 - SDK Usage

To use our SDK, you need a signed in user. You can create a new user or sign in an existing one using the same method [TechCentrixSDK.signIn(...)](https://techcentrix.github.io/resources/ios-sdk/Classes/TechCentrixSDK.html#/s:3SDK011TechCentrixA0C6signIn4with10completionySS_ySbcSgtFZ). Both methods require a special authentication "one time token" which your backend should get from our backend for that particular user (see [How to integrate with a TechCentrix system](https://techcentrix.github.io/quick-start-guide)).

Before starting SDK UI, you must check if a user is signed in. If the user is signed in you can start UI via [TechCentrixSDK.present(...)](https://techcentrix.github.io/resources/ios-sdk/Classes/TechCentrixSDK.html#/s:3SDK011TechCentrixA0C7present2on8animatedySo16UIViewControllerC_SbtFZ) method. If the user is not signed in, TechCentrixSDK will finish itself immediately.

```
import TechCentrixSDK
...
let configuration: TechCentrixSDK.Configuration = [...]
TechCentrixSDK.configure(with: configuration)

if !TechCentrixSDK.isSignedIn() {
	...
	// Obtain one time token from your backend and pass below
	...
	TechCentrixSDK.signIn(with: "oneTimeToken") { (success: Bool) in
			if success {
				TechCentrixSDK.present(on: self)
			} else {
				print("Sign in failed")
			}
	}
} else {
	TechCentrixSDK.present(on: self)
}

```
If your application has a "sign out" option, please call our [TechCentrixSDK.signOut()](https://techcentrix.github.io/resources/ios-sdk/Classes/TechCentrixSDK.html#/s:3SDK011TechCentrixA0C7signOut10completionyyycSg_tFZ) method


### Step 5 - Passing TechCentrix's push notifications

Both iOS & Android app use Firebase to receive push notifications.

Your app will need to pass push notifications to our TechCentrix SDK. You can recognize them using *TechCentrixSDK.isTechCentrixPush(...)* method.

```
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		guard let userInfo: [String: Any] = userInfo as? [String: Any] else {
			completionHandler(.failed)
			return }

      if TechCentrixSDK.isTechCentrixPush(userInfo: info) {
  			TechCentrixSDK.handlePush(with: info) { _ in
  				completionHandler(.newData)
  			}
  		}
	}
```

You also need to pass FCM Token to our SDK.

```
extension AppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		TechCentrixSDK.storeFirebaseRegistrationID(token: fcmToken)
	}
}
```

## API Documentation

We have more in-depth [API documentation](https://techcentrix.github.io/resources/ios-sdk/) for TechCentrix SDK.

## Credits

TechCentrix SDK is owned and maintained by TechCentrix Inc.

## Licence
