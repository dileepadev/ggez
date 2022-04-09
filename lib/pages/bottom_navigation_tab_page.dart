import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'tab_games/games_page.dart';
import 'tab_home/home_page.dart';
import 'tab_store/store_page.dart';
import 'tab_explore/explore_page.dart';
import 'tab_account/account_page.dart';

import '../theme/app_theme.dart';

class BottomNavigationTabPage extends StatefulWidget {
  const BottomNavigationTabPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationTabPageState createState() =>
      _BottomNavigationTabPageState();
}

class _BottomNavigationTabPageState extends State<BottomNavigationTabPage> {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true);

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        FlutterLocalNotificationsPlugin().show(
            remoteNotification.hashCode,
            remoteNotification.title,
            remoteNotification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    //color: Colors.blue,
                    largeIcon:
                        const DrawableResourceAndroidBitmap("@drawable/splash"),
                    icon: '@drawable/splash')));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint('A new onMessageOpenedApp event was published!');
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(remoteNotification.title.toString()),
                content: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(remoteNotification.body.toString()),
                  ],
                )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData homeIcon = Icons.home_outlined;
    IconData gamesIcon = Icons.sports_esports_outlined;
    IconData exploreIcon = Icons.explore_outlined;
    IconData storeIcon = Icons.storefront_outlined;
    IconData accountIcon = Icons.person_outline_rounded;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePage(title: 'Home', iconData: homeIcon),
            GamesPage(title: 'Games', iconData: gamesIcon),
            ExplorePage(title: 'Explore', iconData: exploreIcon),
            StorePage(title: 'Store', iconData: storeIcon),
            AccountPage(title: 'Account', iconData: accountIcon),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 7.0),
          child: TabBar(
            labelColor: AppThemeData.appColorWhite,
            unselectedLabelColor: AppThemeData.appColorGrey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.all(5.0),
            indicatorColor: AppThemeData.appColorRed,
            tabs: [
              Tab(
                icon: Icon(
                  homeIcon,
                  size: 30.0,
                ),
              ),
              Tab(
                icon: Icon(
                  gamesIcon,
                  size: 30.0,
                ),
              ),
              Tab(
                icon: Icon(
                  exploreIcon,
                  size: 30.0,
                ),
              ),
              Tab(
                icon: Icon(
                  storeIcon,
                  size: 30.0,
                ),
              ),
              Tab(
                icon: Icon(
                  accountIcon,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(
        //       Icons.notifications_rounded,
        //       size: 28.0,
        //     ),
        //     foregroundColor: AppThemeData.appColorRed,
        //     backgroundColor: AppThemeData.appColorDarkGrey,
        //     onPressed: () {
        //       debugPrint("Haha");
        //       // FlutterLocalNotificationsPlugin().show(
        //       //     0,
        //       //     'Testing',
        //       //     "Test",
        //       //     NotificationDetails(
        //       //         android:
        //       //             AndroidNotificationDetails(channel.id, channel.name,
        //       //                 channelDescription: channel.description,
        //       //                 importance: Importance.high,
        //       //                 playSound: true,
        //       //                 //color: Colors.blue,
        //       //                 icon: '@mipmap/ic_launcher_2')));
        //       SendOrderSuccessNotification()
        //           .playNotification(GenerateOrderId().ggezOrderId());
        //     }),
      ),
    );
  }
}
