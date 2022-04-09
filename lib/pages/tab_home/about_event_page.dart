import 'package:flutter/material.dart';
import 'package:ggez/models/events_model.dart';
import 'package:ggez/services/firebase_firestore_service.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_elevatedbutton.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

class AboutEventPage extends StatefulWidget {
  const AboutEventPage({Key? key, required this.eventsModel}) : super(key: key);

  final EventsModel eventsModel;

  @override
  _AboutEventPageState createState() => _AboutEventPageState();
}

class _AboutEventPageState extends State<AboutEventPage> {
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
    _registerForEvent() async {
      await FirebaseFirestoreService()
          .firebaseAddEventRegistrationToFirestore(widget.eventsModel, context);
    }

    Widget _eventHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CWText(
              textName: widget.eventsModel.name,
              textStyle: "headline1Bold",
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 5.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Container(
              color: AppThemeData.appColorDark,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: CWText(
                    textName: widget.eventsModel.location,
                    textStyle: "body2Bold",
                    textColor: AppThemeData.appColorWhite),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      );
    }

    Widget _eventDetails() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/icons8_clock_28px.png'),
                    const SizedBox(
                      width: 5.0,
                    ),
                    CWText(
                        textName: widget.eventsModel.time,
                        textStyle: "body2SemiBold",
                        textColor: AppThemeData.appColorWhite),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/icons/icons8_planner_28px.png'),
                    const SizedBox(
                      width: 5.0,
                    ),
                    CWText(
                        textName: widget.eventsModel.date,
                        textStyle: "body2SemiBold",
                        textColor: AppThemeData.appColorWhite),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            CWText(
                textName: widget.eventsModel.name,
                textStyle: "headline1Bold",
                textColor: AppThemeData.appColorWhite),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 28.0,
                  color: AppThemeData.appColorWhite,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                CWText(
                    textName: widget.eventsModel.location,
                    textStyle: "body2SemiBold",
                    textColor: AppThemeData.appColorWhite),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            CWText(
                textName: widget.eventsModel.description,
                textStyle: "body2",
                textColor: AppThemeData.appColorWhite),
            const SizedBox(
              height: 30.0,
            ),
            CWElevatedButton(
                buttonName: 'Register Now',
                onPressed: () => _registerForEvent(),
                // onPressed: _TESTPayment,
                buttonBackgroundColor: AppThemeData.appColorRed),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: CWAppBarPages(appBarName: 'About', context: context).appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.eventsModel.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: AppThemeData.pureColorWhite,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                AppThemeData.appColorDarkWithOpacity,
                                AppThemeData.appColorDark,
                              ],
                              stops: const [
                                0.7,
                                1.5
                              ])),
                    )
                  ],
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppThemeData.appColorDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppThemeData.appCornerRadius),
                        topRight: Radius.circular(AppThemeData.appCornerRadius),
                      ),
                    ),
                    child: _eventDetails(),
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 8,
                    left: 20,
                    right: 5,
                    child: _eventHeader()),
              ],
            ),
          ),
        ));
  }
}
