import 'package:flutter/material.dart';
import 'package:ggez/theme/app_theme.dart';
import 'package:ggez/theme/widgets/cw_message_popups.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import '../../theme/widgets/cw_appbar.dart';
import './get_home_events.dart';
import './get_home_games.dart';
import 'get_home_banners.dart';
import 'get_home_community.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.iconData}) : super(key: key);
  final String title;
  final IconData iconData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Home page refreshed').cwSnackbar(context);
    debugPrint("////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarHomeTab(appBarName: widget.title).appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: AppThemeData.appColorRed,
          backgroundColor: AppThemeData.appColorDark,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              //CWSearchbar(searchKeyWord: "searchKeyWord"),
              //Container(color: Colors.deepPurple, child: const GetHomeBanners()),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: SizedBox(
                  height: 50.0,
                    child: GgezLogoImage()),
              ),
              SizedBox(
                height: 20.0,
              ),
              GetHomeBanners(),
              SizedBox(
                height: 20.0,
              ),
              //Container(color: Colors.green, child: const GetHomeCommunity()),
              GetHomeCommunity(),
              SizedBox(
                height: 10.0,
              ),
              //Container(color: Colors.red, child: const GetHomeGames()),
              GetHomeGames(),
              SizedBox(
                height: 10.0,
              ),
              //Container(color: Colors.amber, child: const GetHomeEvents()),
              GetHomeEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
