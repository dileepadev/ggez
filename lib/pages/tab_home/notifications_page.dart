import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/notifications_model.dart';
import 'package:ggez/services/page_navigation.dart';
import 'package:ggez/theme/widgets/cw_card_notification.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_message_popups.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('notifications').snapshots();

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Notification page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  _getNotifications() {
    return SizedBox(
      //color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CWCircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  //shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    NotificationsModel notificationsModel =
                        NotificationsModel.fromJsom(snapshot.data!.docs[index]);
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CWCardNotifications(
                            notificationsModel: notificationsModel,
                            onPressed: () => PageNavigation(context).goToAboutNotificationPage(
                                notificationsModel)));
                  },
                );
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CWAppBarPages(appBarName: 'Notifications', context: context).appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: _getNotifications(),
          ),
        ),
      ),
    );
  }
}
