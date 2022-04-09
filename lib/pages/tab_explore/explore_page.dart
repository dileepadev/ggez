import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/community_model.dart';
import 'package:ggez/models/order_model.dart';
import 'package:ggez/models/store_model.dart';
import 'package:ggez/models/user_following_model.dart';
import 'package:ggez/services/page_navigation.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import '../../models/user_model.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

import '../../theme/app_theme.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key, required this.title, required this.iconData})
      : super(key: key);
  final String title;
  final IconData iconData;

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();



  final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("orders")
      //.where('followID', isEqualTo: 'RfzRU5y3frv3V4lIGGzx')
      .snapshots();

  final Stream<QuerySnapshot> _followingStream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("following")
      //.where('followID', isEqualTo: 'RfzRU5y3frv3V4lIGGzx')
      .snapshots();


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

  _getUserProfile() {
    return StreamBuilder(
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel =
                        UserModel.fromJsom(snapshot.data!.docs[index]);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _aboutCoins(userModel),
                        const CWText(
                            textName: "My Orders",
                            textStyle: "subtitle1Bold",
                            textColor: AppThemeData.appColorWhite),
                        const SizedBox(height: 5.0,),
                        _orders(userModel),
                        const CWText(
                            textName: "Following",
                            textStyle: "subtitle1Bold",
                            textColor: AppThemeData.appColorWhite),
                        const SizedBox(height: 5.0,),
                        _following(userModel),
                      ],
                    );
                  });
            }
          }
          return const Center(child: CWCircularProgressIndicator());
        });
  }

  Widget _getItemFromStore(OrderModel orderModel) {
    return SizedBox(
      width: 200.0,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("store")
              .where('id', isEqualTo: orderModel.itemID)
              .snapshots(),
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      StoreModel storeModel =
                          StoreModel.fromJsom(snapshot.data!.docs[index]);
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => PageNavigation(context)
                            .goToViewOrderPage(orderModel, storeModel),
                        child: SizedBox(
                          height: 240.0,
                          child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                storeModel.image,
                                fit: BoxFit.fill,
                              )),
                        ),
                      );
                    });
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  Widget _orders(UserModel userModel) {
    return SizedBox(
      height: 250.0,
      child: StreamBuilder(
          stream: _ordersStream,
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      OrderModel orderModel =
                          OrderModel.fromJsom(snapshot.data!.docs[index]);
                      // return Column(
                      //   children: [
                      //     _getItemFromStore(orderModel.itemID),
                      //     CWText(
                      //         textName: orderModel.orderID,
                      //         textStyle: "subtitle1Bold",
                      //         textColor: AppThemeData.appColorWhite),
                      //     CWText(
                      //         textName: orderModel.itemID,
                      //         textStyle: "subtitle1Bold",
                      //         textColor: AppThemeData.appColorWhite),
                      //   ],
                      // );
                      return _getItemFromStore(orderModel);
                    });
              } else {
                return const Center(
                  child: CWText(
                      textName: "Order and earn free coins",
                      textStyle: 'subtitle2SemiBold',
                      textColor: AppThemeData.appColorRed),
                );
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  Widget _aboutCoins(UserModel userModel) {
    return Column(
      children: [
        const SizedBox(width: 150.0, child: GgezLogoImage()),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/icons8_coin_28px_1.png'),
            const SizedBox(
              width: 5.0,
            ),
            CWText(
                textName: "${userModel.coins.toString()} Coins Available",
                textStyle: "subtitle1Bold",
                textColor: AppThemeData.appColorWhite),
          ],
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: CWText(
                  textName: "Earn More",
                  textStyle: "body1SemiBold",
                  textColor: AppThemeData.appColorWhite),
            ),
          ),
        ),
      ],
    );
  }




  Widget _getCommunityFromCommunity(UserFollowingModel userFollowingModel) {
    return SizedBox(
      width: 200.0,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("community")
              .where('id', isEqualTo: userFollowingModel.followID)
              .snapshots(),
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      CommunityModel communityModel =
                      CommunityModel.fromJsom(snapshot.data!.docs[index]);
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          PageNavigation(context).goToAboutCommunityPage(communityModel);
                        },
                        child: Container(
                            width: 175.0,
                            height: 175.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3.0, color: AppThemeData.appColorGrey),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: NetworkImage(communityModel.image)))),
                      );
                    });
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  Widget _following(UserModel userModel) {
    return SizedBox(
      height: 250.0,
      child: StreamBuilder(
          stream: _followingStream,
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserFollowingModel userFollowingModel =
                      UserFollowingModel.fromJsom(snapshot.data!.docs[index]);
                      // return Column(
                      //   children: [
                      //     _getItemFromStore(orderModel.itemID),
                      //     CWText(
                      //         textName: orderModel.orderID,
                      //         textStyle: "subtitle1Bold",
                      //         textColor: AppThemeData.appColorWhite),
                      //     CWText(
                      //         textName: orderModel.itemID,
                      //         textStyle: "subtitle1Bold",
                      //         textColor: AppThemeData.appColorWhite),
                      //   ],
                      // );
                      return _getCommunityFromCommunity(userFollowingModel);
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
            child: _getUserProfile()),
      ),
    );
  }
}
