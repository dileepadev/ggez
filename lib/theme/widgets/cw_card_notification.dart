import 'package:flutter/material.dart';
import 'package:ggez/models/notifications_model.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import './/theme/app_theme.dart';
import './/theme/widgets/cw_text.dart';

class CWCardNotifications extends StatelessWidget {
  const CWCardNotifications(
      {Key? key,
      required this.notificationsModel,
      required this.onPressed})
      : super(key: key);

  final NotificationsModel notificationsModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {


    String croppedDescription = "${notificationsModel.description.substring(0, 90)} .........";


    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            // leading: Container(
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(
            //     color: AppThemeData.appColorGrey,
            //     borderRadius: BorderRadius.circular(20.0),
            //   ),
            //   child: Image.network(
            //     FirebaseFirestoreService().defaultUserAvatar,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            leading: const SizedBox(
              width: 60,
              // decoration: BoxDecoration(
              //   color: AppThemeData.appColorDark,
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              child: Center(child: GgezLogoImage()),
            ),
            title: CWText(
                textName: notificationsModel.title,
                textStyle: 'body1SemiBold',
                textColor: AppThemeData.appColorWhite),
            subtitle: CWText(
                textName: croppedDescription,
                textStyle: 'caption1',
                textColor: AppThemeData.appColorWhite),
            trailing: const Icon(Icons.more_vert),
            isThreeLine: true,
            onTap: onPressed,
          ),
        ));
  }
}
