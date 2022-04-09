import 'package:flutter/material.dart';
import 'package:ggez/models/notifications_model.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

class AboutNotificationPage extends StatefulWidget {
  const AboutNotificationPage({Key? key, required this.notificationsModel})
      : super(key: key);

  final NotificationsModel notificationsModel;

  @override
  _AboutNotificationPageState createState() => _AboutNotificationPageState();
}

class _AboutNotificationPageState extends State<AboutNotificationPage> {
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Banner page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CWAppBarPages(appBarName: 'About', context: context).appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: CWText(
                      textName: widget.notificationsModel.title,
                      textStyle: "headline5SemiBold",
                      textColor: AppThemeData.appColorWhite),
                ),
                Center(
                  child: CWText(
                      textName: widget.notificationsModel.date,
                      textStyle: "subtitle1",
                      textColor: AppThemeData.appColorWhite),
                ),
                const SizedBox(height: 20.0,),
                Card(
                  margin: const EdgeInsets.only(right: 10),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    width: 350,
                    child: Image.network(
                      widget.notificationsModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                Center(
                  child: CWText(
                      textName: widget.notificationsModel.description,
                      textStyle: "body1",
                      textColor: AppThemeData.appColorWhite),
                ),
              ],
            ),
          ),
        ));
  }
}
