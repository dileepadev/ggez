import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/community_model.dart';
import 'package:ggez/services/firebase_firestore_service.dart';
import 'package:ggez/theme/widgets/cw_button_follow.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

class AboutCommunityPage extends StatefulWidget {
  const AboutCommunityPage({Key? key, required this.communityModel})
      : super(key: key);

  final CommunityModel communityModel;

  @override
  _AboutCommunityPageState createState() => _AboutCommunityPageState();
}

class _AboutCommunityPageState extends State<AboutCommunityPage> {
  bool isFollowCommunity = false;

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Community page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  Future<void> _changeFollowingStatus(bool followingStatus) async {
    if (!isFollowCommunity) {
      debugPrint("Start to Follow");
      await FirebaseFirestoreService().firebaseUpdateUserFollowingsToFirestore(
          'following',
          widget.communityModel.id,
          widget.communityModel.name,
          widget.communityModel.category,
          true,
          context);
    } else {
      debugPrint("Start to Unfollow");
      await FirebaseFirestoreService().firebaseUpdateUserFollowingsToFirestore(
          'following',
          widget.communityModel.id,
          widget.communityModel.name,
          widget.communityModel.category,
          false,
          context);
    }

    debugPrint("Must to change following status $followingStatus");
  }

  Widget _follow() {
    return CWButtonFollow(
        isFollow: isFollowCommunity,
        onPressed: () {
          setState(() {
            _changeFollowingStatus(isFollowCommunity);
            if (isFollowCommunity) {
              isFollowCommunity = false;
            } else {
              isFollowCommunity = true;
            }
          });
        });
  }

  displayFollowings() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("following")
            .where('followID', isEqualTo: widget.communityModel.id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            debugPrint("Not Following");
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CWCircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              debugPrint("Following");
              isFollowCommunity = true;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _follow(),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Icon(
                    Icons.message_rounded,
                    size: 28.0,
                    color: AppThemeData.appColorWhite,
                  ),
                ],
              );
            } else {
              debugPrint("Not Following");
            }
          }
          return Column(
            children: [
              _follow(),
            ],
          );
        });
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
                Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(widget.communityModel.image)))),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: CWText(
                      textName: widget.communityModel.name,
                      textStyle: "headline5SemiBold",
                      textColor: AppThemeData.appColorWhite),
                ),
                Center(
                  child: CWText(
                      textName:
                          "${widget.communityModel.followers.toString()} Reputation",
                      textStyle: "body1SemiBold",
                      textColor: AppThemeData.appColorWhite),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(child: displayFollowings()),
              ],
            ),
          ),
        ));
  }
}
