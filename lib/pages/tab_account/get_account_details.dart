import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/theme/widgets/cw_circle_image.dart';

import '../../models/user_following_model.dart';
import '../../models/user_model.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_text.dart';

class GetAccountDetails extends StatefulWidget {
  const GetAccountDetails({Key? key}) : super(key: key);

  @override
  _GetAccountDetailsState createState() => _GetAccountDetailsState();
}

class _GetAccountDetailsState extends State<GetAccountDetails> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  final Stream<QuerySnapshot> _communityStream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("following")
      //.where('followID', isEqualTo: 'RfzRU5y3frv3V4lIGGzx')
      .snapshots();


  Widget _displayFollowings() {
    return SizedBox(
      //color: Colors.blue,
      height: 150.0,
      child: StreamBuilder(
          stream: _communityStream,
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
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      UserFollowingModel userFollowingModel =
                          UserFollowingModel.fromJsom(
                              snapshot.data!.docs[index]);
                      return CWText(
                          textName: userFollowingModel.followName,
                          textStyle: 'body1',
                          textColor: AppThemeData.appColorWhite);
                    });
              } else {
                return const Center(
                  child: CWText(
                      textName: "Follow and earn free coins",
                      textStyle: 'subtitle2SemiBold',
                      textColor: AppThemeData.appColorRed),
                );
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  Widget _header(UserModel userModel) {
    return Column(
      children: [
        Center(
          child: CWCircleImage(
              image: userModel.profileImage,
              onPressed: () {
                debugPrint("Hello Profile");
              }),
        ),
        Center(
          child: CWText(
              textName: userModel.name,
              textStyle: "headline4Bold",
              textColor: AppThemeData.appColorWhite),
        ),
        Center(
          child: CWText(
              textName: userModel.ggezId,
              textStyle: "body1",
              textColor: AppThemeData.appColorWhite),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Center(
          child: Container(
            decoration: const BoxDecoration(
                color: AppThemeData.appColorRed,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppThemeData.appCornerRadius))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: CWText(
                  textName: userModel.accountType,
                  textStyle: "body1SemiBold",
                  textColor: AppThemeData.appColorWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutArea(UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_rounded,
                color: AppThemeData.appColorWhite),
            const SizedBox(
              width: 5.0,
            ),
            CWText(
                textName: userModel.address,
                textStyle: "body1",
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            const Icon(Icons.money, color: AppThemeData.appColorWhite),
            const SizedBox(
              width: 5.0,
            ),
            CWText(
                textName: "${userModel.coins.toString()} Ggez",
                textStyle: "body1",
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Icon(userModel.verified ? Icons.verified : Icons.pending_rounded,
                color: AppThemeData.appColorWhite),
            const SizedBox(
              width: 5.0,
            ),
            CWText(
                textName:
                    userModel.verified ? 'Verified User' : 'Unverified User',
                textStyle: "body1",
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        const CWText(
            textName: "About Me",
            textStyle: "subtitle1Bold",
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: userModel.about.toString(),
            textStyle: "body1",
            textColor: AppThemeData.appColorWhite),
        // const SizedBox(
        //   height: 20.0,
        // ),
        // const CWText(
        //     textName: "Following Games",
        //     textStyle: "subtitle1Bold",
        //     textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 10.0,
        ),
        const CWText(
            textName: "Following",
            textStyle: "subtitle1Bold",
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 10.0,
        ),
        _displayFollowings(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CWCircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel =
                        UserModel.fromJsom(snapshot.data!.docs[index]);
                    return Column(
                      children: [
                        _header(userModel),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // _actionArea(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _aboutArea(userModel),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    );
                  });
            }
          }
          return const Center(child: CWCircularProgressIndicator());
        });
  }
}
