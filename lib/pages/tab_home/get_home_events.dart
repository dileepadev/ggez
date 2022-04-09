import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/events_model.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_card_home_events.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_text.dart';

class GetHomeEvents extends StatefulWidget {
  const GetHomeEvents({Key? key}) : super(key: key);

  @override
  _GetHomeEventsState createState() => _GetHomeEventsState();
}

class _GetHomeEventsState extends State<GetHomeEvents> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  _events() {
    return SizedBox(
      //color: Colors.blue,
      height: 230.0,
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
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      EventsModel eventsModel =
                          EventsModel.fromJsom(snapshot.data!.docs[index]);
                      return Column(
                        children: [
                          CWCardHomeEvents(
                              eventsModel: eventsModel,
                              onPressed: () => PageNavigation(context)
                                  .goToAboutEventPage(eventsModel))
                        ],
                      );
                    });
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CWText(
            textName: 'Events',
            textStyle: 'subtitle1Bold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        _events(),
      ],
    );
  }
}
