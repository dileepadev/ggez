import 'package:flutter/material.dart';
import 'package:ggez/pages/tab_account/get_account_details.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_message_popups.dart';

import '../../theme/app_theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key, required this.title, required this.iconData})
      : super(key: key);
  final String title;
  final IconData iconData;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Account page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  // void firebaseSignOut() async {
  //   bool? isSignOut = await FirebaseAuthService().firebaseSignOut(context);
  //   if (isSignOut) {
  //     PageNavigation(context).goToIntroPage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarOtherTabs(
              appBarName: widget.title,
              iconName: widget.iconData,
              context: context)
          .appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: const GetAccountDetails()),
      ),
    );
  }
}
