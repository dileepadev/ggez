import 'package:flutter/material.dart';
import 'package:ggez/pages/tab_store/get_store_items.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_message_popups.dart';

import '../../theme/app_theme.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key, required this.title, required this.iconData})
      : super(key: key);
  final String title;
  final IconData iconData;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Store page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarOtherTabs(
              appBarName: widget.title, iconName: widget.iconData, context: context)
          .appBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: RefreshIndicator(
              onRefresh: _refreshData,
              color: AppThemeData.appColorRed,
              backgroundColor: AppThemeData.appColorDark,
              // child: _getStoreTestItems())),
              child: const GetStoreItems())),
    );
  }
}
