import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/games_model.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../theme/widgets/cw_card_games_games.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';

class GetGamesGames extends StatefulWidget {
  const GetGamesGames({Key? key}) : super(key: key);

  @override
  _GetGamesGamesState createState() => _GetGamesGamesState();
}

class _GetGamesGamesState extends State<GetGamesGames> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('games').snapshots();

  _games() {
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
                return GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    GamesModel gamesModel =
                        GamesModel.fromJsom(snapshot.data!.docs[index]);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CWCardGamesGames(
                          name: gamesModel.name,
                          image: gamesModel.image,
                          followers: gamesModel.followers,
                          onPressed: () {
                            PageNavigation(context)
                                .goToAboutGamePage(gamesModel);
                          }),
                    );
                  }),
                );
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _games();
  }
}
