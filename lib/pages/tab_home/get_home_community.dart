import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../models/community_model.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_card_home_community.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_text.dart';

class GetHomeCommunity extends StatefulWidget {
  const GetHomeCommunity({Key? key}) : super(key: key);

  @override
  _GetHomeCommunityState createState() => _GetHomeCommunityState();
}

class _GetHomeCommunityState extends State<GetHomeCommunity> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('community').snapshots();

  _community() {
    return SizedBox(
      //color: Colors.blue,
      height: 150.0,
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
                      CommunityModel communityModel =
                      CommunityModel.fromJsom(snapshot.data!.docs[index]);
                      return CWCardHomeCommunity(
                          name: communityModel.name,
                          image: communityModel.image,
                          followers: communityModel.followers,
                          onPressed: () => PageNavigation(context).goToAboutCommunityPage(
                              communityModel));
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
            textName: 'E-Sport Community',
            textStyle: 'subtitle1Bold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 10.0,
        ),
        _community()
      ],
    );
  }
}
