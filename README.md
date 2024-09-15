<h1 align="center">EV-Connect</h1>

## 📱 Demo

<div align="center">
  <video src="https://github.com/user-attachments/assets/53881228-d2f5-4920-981d-80b903971fe6" />
</div>

## Technologies

- iOS 17 / Xcode 15
- Swift 5
- SwiftUI 5
- MapKit
- MVVM

## Features

- Charging Car UI
- Music Player UI
- Car Controls
- Voice Command
- Navigation Map
- Custom Map Annotations
- App Icon
- SplashScreen Animation

## 🚀 Getting Started

**The app targets iOS 17 and above. Make sure you have Xcode 15+ installed.**

1. Clone the repository:

```sh
git clone https://github.com/jus3472/EV-Connect.git
```

2. Navigate to the Project Directory:

```sh
cd EV-Connect
```

3. Open the project in Xcode:

```sh
open EV-Connect.xcodeproj
```

3. Set Up Firebase:

This project uses Firebase for authentication and other services. To run the app locally, you need to set up your own Firebase project and obtain the necessary configuration file (GoogleService-Info.plist).

Steps to Set Up Firebase:
1. Go to the Firebase Console.
2. Create a new Firebase project.
3. In the Firebase Console, navigate to Project Settings and under the Your apps section, add an iOS app.
4. Enter your app's Bundle ID (e.g., com.yourname.EV-Connect), and register the app.
5. Download the generated GoogleService-Info.plist file.
6. Place the GoogleService-Info.plist file in the Xcode project folder (at the same level as Assets.xcassets, etc).
- Without this file, the app will not build or connect to Firebase services properly.

5. To build and run the app, select a simulator or connected iOS device and press:

```sh
Cmd + R
```
