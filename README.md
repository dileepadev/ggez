# 🎮 GGEZ Network (BRANCH: main)

![GitHub repo size](https://img.shields.io/github/repo-size/dileepabandara/ggez?color=red&label=repository%20size)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dileepabandara/ggez?color=red)
![GitHub language count](https://img.shields.io/github/languages/count/dileepabandara/ggez)
![GitHub top language](https://img.shields.io/github/languages/top/dileepabandara/ggez)
![GitHub](https://img.shields.io/github/license/dileepabandara/ggez?color=yellow)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/dileepabandara/ggez?color=brightgreen&label=commits)

![GGEZCover](https://dileepabandara.github.io/public-images/projects/ggez/ggez-cover-rounded-qr.png)

## ⚠️ SPECIAL NOTICE

Please use the dev branch to develop and test your ideas.

## 🎬 Release Status

Version - Alpha Release 1.0.0+1  
Initial release date - 14/03/2022

## 💻 Built with

- Flutter
- Dart
- Android Studio
- Firebase
- Solidity (Testing)
- Etherium (Testing)

## 📌 Prerequisites

Before you get started, follow these requirements

- Dart SDK >=2.16.1 <3.0.0
- Flutter SDK >=2.0.0
- Android Gradle Plugin Version = 7.0.4
- Gradle Version = 7.0.2
- PayHere account - [Example App](https://github.com/dileepabandara/flutter_with_payhere)

## 🍃 How to Setup

- Download or clone the repository
- Move the project to the selected directory
- Open it with a code editor (Android Studio, Visual Studio Code)
- Run flutter clean and pub get commands
- Do not update / upgrade gradle and other versions until the app is up and running with built versions
- Create new dart file (payhere_credentials.dart) to save the merchantSecret and merchantId  
    
  <b><i>payhere_credentials.dart</i></b>

  ```
  class PayHereAccountCredentials {
      final String merchantId = "Paste YOUR MERCHANT ID";
      final String merchantSecret = "Paste YOUR MERCHANT SECRET";
  }
  ```
  
  <b>PayHere Sandbox & Testing Card numbers</b>

  | Card Icon                                                      | Card Name  | Card Number      |
  | :------------------------------------------------------------- | :--------- | :--------------- |
  | ![VISA](https://img.icons8.com/color/40/000000/visa.png)       | Visa       | 4916217501611292 |
  | ![VISA](https://img.icons8.com/color/40/000000/mastercard.png) | MasterCard | 5307732125531191 |
  | ![VISA](https://img.icons8.com/color/40/000000/amex.png)       | AMEX       | 346781005510225  |

## 🚀 How to Run

- Run flutter clean and pub get commands
- Launch Device
- Run on the device

## 💎 Dependencies

- [Flutter](https://flutter.dev)
- [firebase_auth: ^3.3.7](https://pub.dev/packages/firebase_auth)
- [firebase_core: ^1.12.0](https://pub.dev/packages/firebase_core)
- [cloud_firestore: ^3.1.8](https://pub.dev/packages/cloud_firestore)
- [firebase_analytics: ^9.1.0](https://pub.dev/packages/firebase_analytics)
- [firebase_messaging: ^11.2.6](https://pub.dev/packages/firebase_messaging)
- [firebase_crashlytics: ^2.5.1](https://pub.dev/packages/firebase_crashlytics)
- [intl: ^0.17.0](https://pub.dev/packages/intl)
- [flutter_local_notifications: ^9.3.2](https://pub.dev/packages/flutter_local_notifications)
- [payhere_mobilesdk_flutter: ^2.0.0](https://pub.dev/packages/payhere_mobilesdk_flutter)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [crypto: ^3.0.1](https://pub.dev/packages/crypto)

## 🎯 TODO

- [x] Create basic process
- [x] Create models for components
- [x] setState for state management 
- [x] Payment method with PayHere
- [x] Cloud messaging (Push notifications)
- [ ] Add alternative payment methods
- [ ] Upgrate to propper state management
- [ ] Apply model components for remaining usage
- [ ] Connect crypto wallet to app
- [ ] Optimize GTN token
- [ ] Clean code
- [ ] Add social login/signup/signin

## 👑 Contributing

If you want to contribute to this project and make it better, your help is very welcome. Just fork the repository and use the dev branch.

## 🖼️ Project Gallery

Project screenshots and pictures - [Click here to view](https://www.figma.com/file/w38wzdUpm9T3Mud3lCCp2i/GGEZ---Mobile-App-UI?node-id=0%3A1)

## ❤️ Thanks

Thanks to everyone who supported

## 👨‍💻 Developed By

Dileepa Bandara  
©dileepabandara.dev  
<https://dileepabandara.dev>

## 💬 Contact

If you want to contact me, leave a message via email or Twitter

- Email - <contact.dileepabandara@gmail.com>
- Twitter - [_dileepabandara](https://twitter.com/_dileepabandara)

## 📜 License

This project is licensed under the MIT License  
MIT ©dileepabandara.dev  
See the license file for more details [LICENSE.md](https://github.com/dileepabandara/ggez/blob/main/LICENSE)
