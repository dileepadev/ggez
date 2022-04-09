import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/games_model.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_card_home_games.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_text.dart';

class GetHomeGames extends StatefulWidget {
  const GetHomeGames({Key? key}) : super(key: key);

  @override
  _GetHomeGamesState createState() => _GetHomeGamesState();
}

class _GetHomeGamesState extends State<GetHomeGames> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('games').snapshots();

  _games() {
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
                      GamesModel gamesModel =
                      GamesModel.fromJsom(snapshot.data!.docs[index]);
                      return Column(
                        children: [
                          CWCardHomeGames(
                              gamesModel: gamesModel,
                              onPressed: () => PageNavigation(context).goToAboutGamePage(
                                  gamesModel)),
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
            textName: 'Games',
            textStyle: 'subtitle1Bold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        _games(),
      ],
    );
  }
}
